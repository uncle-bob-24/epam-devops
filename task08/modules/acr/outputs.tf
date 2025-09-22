output "acr_id" {
  description = "The ID of the Azure Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "The login server of the ACR (used to pull images)"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_image_url" {
  description = "The URL of the Docker image in the Azure Container Registry"
  value       = format("%s/%s:latest", azurerm_container_registry.acr.login_server, var.docker_image_name)
}

output "acr_username" {
  description = "The username for the Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_password" {
  description = "The password for the Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}