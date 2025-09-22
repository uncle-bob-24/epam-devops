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

variable "tags" {
  description = "Tags to apply to the Azure Key Vault"
  type        = map(string)
}