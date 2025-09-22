region                   = "East US"
prefix                   = "cmtr-65725fc3-mod8"
aci_sku                  = "Standard"
aci_cpu                  = 2
aci_memory               = 2
acr_sku                  = "Basic"
container_port           = 80
redis_capacity           = 2
redis_sku_name           = "Basic"
redis_sku_family         = "C"
repository_url           = "https://github.com/uncle-bob-24/epam-devops.git"
dockerfile_path          = "task08/application/Dockerfile"
node_pool_name           = "system"
node_count               = 1
node_vm_size             = "Standard_D2ads_v5"
os_disk_type             = "Ephemeral"
keyvault_sku             = "standard"
redis_hostname_secret    = "redis-hostname"
redis_primary_key_secret = "redis-primary-key"

tags = {
  Creator = "azamat_kireyev@epam.com"
}
