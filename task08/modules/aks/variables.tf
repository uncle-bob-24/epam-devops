variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region to deploy the AKS cluster"
  type        = string
}

# Default Node Pool Configuration
variable "node_pool_name" {
  description = "Default node pool name for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "node_vm_size" {
  description = "VM size for VMs in the default node pool"
  type        = string
}

variable "os_disk_type" {
  description = "OS disk type for nodes (Ephemeral or Managed)"
  type        = string
}

# ACR Integration: Required ID of Azure Container Registry
variable "acr_id" {
  description = "The ID of the Azure Container Registry to enable ACR Pull for AKS"
  type        = string
}

# Key Vault Secrets
variable "keyvault_id" {
  description = "The ID of the Azure Key Vault to enable secrets access for the AKS cluster"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Name of the Key Vault secret containing the Redis hostname"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Name of the Key Vault secret containing the Redis primary key"
  type        = string
}

# Tags
variable "tags" {
  description = "Tags applied to AKS resources"
  type        = map(string)
}