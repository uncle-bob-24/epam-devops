# Output: Key Vault ID
output "keyvault_id" {
  description = "The ID of the Azure Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

# Output: Redis Hostname Secret Value
output "redis_hostname_secret_value" {
  description = "The value of the Redis hostname stored in Key Vault"
  value       = azurerm_key_vault_secret.redis_hostname.value
  sensitive   = true
}

# Output: Redis Primary Key Secret Value
output "redis_primary_key_secret_value" {
  description = "The value of the Redis primary key stored in Key Vault"
  value       = azurerm_key_vault_secret.redis_primary_key.value
  sensitive   = true
}