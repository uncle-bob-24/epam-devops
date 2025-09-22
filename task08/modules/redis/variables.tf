# Redis Cache Configuration
variable "redis_name" {
  description = "The name of the Azure Redis Cache instance"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group where Redis Cache will be provisioned"
  type        = string
}

variable "location" {
  description = "Azure region for the Redis Cache"
  type        = string
}

variable "capacity" {
  description = "The capacity of the Redis Cache instance (e.g., 1 = 250MB, 2 = 1GB)"
  type        = number
}

variable "sku_name" {
  description = "SKU of the Redis Cache instance (e.g., Basic, Standard, Premium)"
  type        = string
}

variable "sku_family" {
  description = "SKU Family of the Redis Cache instance (e.g., C)"
  type        = string
}

# Key Vault Configuration
variable "keyvault_id" {
  description = "The ID of the Azure Key Vault where secrets will be stored"
  type        = string
}

variable "redis_hostname_secret" {
  description = "Name of the Key Vault secret for storing Redis hostname"
  type        = string
}

variable "redis_primary_key_secret" {
  description = "Name of the Key Vault secret for storing Redis primary key"
  type        = string
}

# Tags
variable "tags" {
  description = "Tags to apply to the Redis Cache instance"
  type        = map(string)
}