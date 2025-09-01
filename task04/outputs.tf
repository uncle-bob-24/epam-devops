output "vm_public_ip" {
  description = "The VM public IP"
  value       = azurerm_public_ip.pip.ip_address
}

output "vm_fqdn" {
  description = "VM fqdn"
  value       = azurerm_public_ip.pip.fqdn
}