resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "build_task" {
  name                  = "${var.name}-build-task"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os           = "Linux"
    architecture = "amd64"
  }

  docker_step {
    dockerfile_path      = "task08/application/Dockerfile"
    context_path         = var.git_repo_url
    context_access_token = var.git_pat
    image_names          = ["${var.image_name}:latest"]
  }

  source_trigger {
    name           = "source_trigger"
    events         = ["commit"]
    repository_url = var.git_repo_url
    source_type    = "Github"

    authentication {
      token      = var.git_pat
      token_type = "PAT"
    }
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "build" {
  container_registry_task_id = azurerm_container_registry_task.build_task.id
}
