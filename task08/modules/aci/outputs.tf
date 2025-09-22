output "aci_id" {
  description = "ID of the Container Instance"
  value       = azurerm_container_group.aci.id
}

output "aci_ip_address" {
  description = "IP address of the Container Instance"
  value       = azurerm_container_group.aci.ip_address
}

output "aci_fqdn" {
  description = "FQDN of the Container Instance"
  value       = azurerm_container_group.aci.fqdn
}