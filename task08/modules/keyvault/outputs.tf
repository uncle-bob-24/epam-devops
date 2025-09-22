# Output: Key Vault ID
output "keyvault_id" {
  description = "The ID of the Azure Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

