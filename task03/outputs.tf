output "rg_id" {
  description = "The resource group Id"
  value       = azurerm_resource_group.cmaz-65725fc3-mod3-rg.id
}

output "sa_blob_endpoint" {
  description = "Storage account blob service primary endpoint"
  value       = azurerm_storage_account.cmaz65725fc3sa.primary_blob_endpoint
}

output "vnet_id" {
  description = "The Virtual network Id"
  value       = azurerm_virtual_network.cmaz-65725fc3-mod3-vnet.id
}