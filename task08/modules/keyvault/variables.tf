variable "keyvault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for the Azure Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region to deploy the Key Vault"
  type        = string
}

variable "sku" {
  description = "SKU for the Azure Key Vault (standard or premium)"
  type        = string
}

variable "aks_identity_object_id" {
  description = "Object ID of the AKS agent identity for Key Vault access policy"
  type        = string
}

variable "redis_hostname" {
  description = "Redis hostname to store as a secret in Key Vault"
  type        = string
}

variable "redis_primary_key" {
  description = "Redis primary key to store as a secret in Key Vault"
  type        = string
  sensitive   = true
}

variable "redis_hostname_secret" {
  description = "Name of the Key Vault secret for Redis hostname"
  type        = string
}

variable "redis_primary_key_secret" {
  description = "Name of the Key Vault secret for Redis primary key"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Azure Key Vault"
  type        = map(string)
}