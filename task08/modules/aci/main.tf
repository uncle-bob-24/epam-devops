resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_address_type     = "Public"
  os_type             = "Linux"
  sku                 = var.aci_sku

  container {
    name   = var.container_name
    image  = var.container_image # Docker image pulled from ACR
    cpu    = var.cpu
    memory = var.memory

    # Define public ports for external access
    ports {
      port     = var.container_port
      protocol = "TCP"
    }

    # Unsecured environment variables
    environment_variables = {
      CREATOR        = "ACI"  # Identifier for ACI (non-sensitive)
      REDIS_PORT     = "6380" # Connect to Redis on SSL port
      REDIS_SSL_MODE = "True" # Enable Redis SSL mode
    }

    # Secure environment variables from Key Vault
    secure_environment_variables = {
      REDIS_URL = var.redis_url # Redis hostname from Key Vault
      REDIS_PWD = var.redis_pwd # Redis primary key from Key Vault
    }
  }


  # Reference ACR credentials for pulling images
  image_registry_credential {
    server   = var.acr_login_server # ACR registry login server
    username = var.acr_username     # ACR username
    password = var.acr_password     # ACR password (sensitive)
  }

  tags = var.tags
}