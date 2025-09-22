output "acr_id" {
  description = "ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "Login server of the Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "Admin username of the Container Registry"
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  description = "Admin password of the Container Registry"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}