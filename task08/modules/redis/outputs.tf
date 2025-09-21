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