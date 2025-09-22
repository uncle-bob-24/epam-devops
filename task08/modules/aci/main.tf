resource "azurerm_container_group" "aci" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = var.name
  os_type             = "Linux"

  container {
    name   = "app"
    image  = "${var.acr_login_server}/${var.image_name}:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "true"
    }

    secure_environment_variables = {
      REDIS_URL = var.redis_hostname
      REDIS_PWD = var.redis_primary_key
    }
  }

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_username
    password = var.acr_password
  }

  tags = var.tags
}