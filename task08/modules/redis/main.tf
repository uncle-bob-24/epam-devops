# Create Azure Redis Cache instance
resource "azurerm_redis_cache" "redis" {
  name                 = var.redis_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  capacity             = var.capacity
  sku_name             = var.sku_name
  family               = var.sku_family
  non_ssl_port_enabled = false # Enforce SSL connections only (replaces enable_non_ssl_port)

  minimum_tls_version = "1.2"

  tags = var.tags
}

# Store Redis Hostname in Azure Key Vault
resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.keyvault_id

  tags = var.tags
}

# Store Redis Primary Key in Azure Key Vault
resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_primary_key_secret
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.keyvault_id

  tags = var.tags
}