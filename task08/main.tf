data "azurerm_client_config" "current" {}

# Create the Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.region
  tags     = var.tags
}

# Key Vault Module
module "keyvault" {
  source              = "./modules/keyvault"
  keyvault_name       = local.keyvault_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.keyvault_sku

  # Tags for Key Vault
  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "aks_identity_kv_access" {
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = module.aks.aks_user_object_id
  key_vault_id = module.keyvault.keyvault_id
  secret_permissions = ["Get", "List"]
  depends_on         = [module.keyvault]
}

# Redis Module
module "redis" {
  source                   = "./modules/redis"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.region
  redis_name               = local.redis_name
  capacity                 = var.redis_capacity
  sku_name                 = var.redis_sku_name
  sku_family               = var.redis_sku_family
  keyvault_id              = module.keyvault.keyvault_id
  redis_hostname_secret    = var.redis_hostname_secret
  redis_primary_key_secret = var.redis_primary_key_secret
  tags                     = var.tags
}

# Container Registry Module
module "acr" {
  source              = "./modules/acr"
  acr_name            = local.acr_name # Use the name dynamically generated in locals
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
  acr_sku             = var.acr_sku
  repository_url      = var.repository_url
  dockerfile_path     = var.dockerfile_path
  git_pat             = var.git_pat             # Sensitive GitHub Personal Access Token (PAT)
  docker_image_name   = local.docker_image_name # Docker image name
  tags                = var.tags
}

# Azure Container Instance Module
module "aci" {
  source              = "./modules/aci"
  aci_name            = local.aci_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
  aci_sku             = var.aci_sku

  container_name  = local.docker_image_name
  container_image = module.acr.acr_image_url # Pull Docker image from ACR
  cpu             = var.aci_cpu
  memory          = var.aci_memory
  container_port  = var.container_port
  dns_name_label  = local.dns_name_label

  # Pass the acr_login_server output from the acr module
  acr_login_server = module.acr.acr_login_server
  acr_username     = module.acr.acr_username
  acr_password     = module.acr.acr_password

  redis_url = module.redis.redis_hostname_secret_value
  redis_pwd = module.redis.redis_primary_key_secret_value

  tags = var.tags
}

# AKS Module
module "aks" {
  source = "./modules/aks"

  aks_name            = local.aks_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
  node_pool_name      = var.node_pool_name
  node_count          = var.node_count
  node_vm_size        = var.node_vm_size
  os_disk_type        = var.os_disk_type

  # Pass the acr_id from the ACR module
  acr_id = module.acr.acr_id

  keyvault_id                   = module.keyvault.keyvault_id
  redis_hostname_secret_name    = var.redis_hostname_secret
  redis_primary_key_secret_name = var.redis_primary_key_secret
  tags                          = var.tags
}

# Deployment Kubernetes Manifest YAMLs
resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server # ACR login server
    app_image_name   = local.docker_image_name
    image_tag        = "latest" # Docker image tag
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider]
}

# Kubernetes Service Manifest
resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml") # Reference the Kubernetes Service manifest file

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}" # Regular expression for an IPv4 address
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment] # Ensure the deployment is applied first
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    kv_name                    = local.keyvault_name # Add Key Vault name as `kv_name`
    redis_url_secret_name      = var.redis_hostname_secret
    redis_password_secret_name = var.redis_primary_key_secret
    tenant_id                  = data.azurerm_client_config.current.tenant_id # Azure Tenant ID
    aks_kv_access_identity_id  = module.aks.aks_user_object_id                # AKS-managed identity ID for Key Vault access
  })

  depends_on = [module.keyvault, module.redis]
}

data "kubernetes_service" "service" {
  metadata {
    name = "redis-flask-app-service"
  }

  depends_on = [kubectl_manifest.service]
}