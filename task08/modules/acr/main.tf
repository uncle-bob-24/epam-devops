resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku

  admin_enabled = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "acr_task" {
  name                  = "add_image"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os           = "Linux"
    architecture = "amd64"
  }

  docker_step {
    dockerfile_path      = var.dockerfile_path
    context_path         = "${var.repository_url}#main:${trimsuffix(var.dockerfile_path, "/Dockerfile")}"
    context_access_token = var.git_pat
    image_names          = ["${var.docker_image_name}:latest"]
  }

  source_trigger {
    name           = "source_trigger"
    events         = ["commit"]
    repository_url = var.repository_url
    source_type    = "Github"

    authentication {
      token      = var.git_pat
      token_type = "PAT"
    }
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "build" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id
}