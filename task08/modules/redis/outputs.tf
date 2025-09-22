# Output: Redis Cache Hostname
output "redis_hostname" {
  description = "The hostname of the Redis Cache instance"
  value       = azurerm_redis_cache.redis.hostname
}

output "redis_primary_key" {
  description = "The primary access key for the Redis Cache instance"
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

# Output: Redis Cache ID
output "redis_id" {
  description = "The ID of the Redis Cache instance"
  value       = azurerm_redis_cache.redis.id
}

output "redis_hostname_secret_value" {
  description = "Redis hostname secret value"
  value       = azurerm_key_vault_secret.redis_hostname.value
  sensitive   = true
}

output "redis_primary_key_secret_value" {
  description = "Redis primary key secret value"
  value       = azurerm_key_vault_secret.redis_primary_key.value
  sensitive   = true
}
