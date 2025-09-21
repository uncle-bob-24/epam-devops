output "aci_fqdn" {
  description = "FQDN of the deployed Azure Container Instance"
  value       = azurerm_container_group.aci.fqdn
}