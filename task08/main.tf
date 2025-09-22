data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

module "keyvault" {
  source              = "./modules/keyvault"
  name                = local.keyvault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  tags                = local.common_tags
}

module "redis" {
  source              = "./modules/redis"
  name                = local.redis_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  key_vault_id        = module.keyvault.key_vault_id
  tags                = local.common_tags

  depends_on = [module.keyvault]
}

module "acr" {
  source              = "./modules/acr"
  name                = local.acr_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.acr_sku
  git_repo_url        = var.git_repo_url
  git_pat             = var.git_pat
  image_name          = "${var.name_prefix}-app"
  tags                = local.common_tags
}

module "aks" {
  source              = "./modules/aks"
  name                = local.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  acr_id              = module.acr.acr_id
  key_vault_id        = module.keyvault.key_vault_id
  tags                = local.common_tags
}

module "aci" {
  source              = "./modules/aci"
  name                = local.aci_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  acr_login_server    = module.acr.acr_login_server
  acr_username        = module.acr.acr_admin_username
  acr_password        = module.acr.acr_admin_password
  image_name          = "${var.name_prefix}-app"
  redis_hostname      = module.redis.redis_hostname_secret_value
  redis_primary_key   = module.redis.redis_primary_key_secret_value
  tags                = local.common_tags

  depends_on = [module.acr, module.redis]
}

# Deploy Kubernetes manifests
resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.kubelet_identity_object_id
    kv_name                    = module.keyvault.key_vault_name
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-primary-key"
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })

  depends_on = [module.aks, module.keyvault, module.redis]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = "${var.name_prefix}-app"
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.readyReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider, module.acr]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key   = "status.loadBalancer.ingress.0.ip"
      value = "regex:^\\d+\\.\\d+\\.\\d+\\.\\d+$"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service" "app_service" {
  metadata {
    name = "redis-flask-app-service"
  }

  depends_on = [kubectl_manifest.service]
}