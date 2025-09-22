# General Configuration Variables
variable "region" {
  description = "Azure region to deploy the resources"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

# Redis Variables
variable "redis_capacity" {
  description = "Redis Cache capacity (1 = 250 MB, 2 = 1 GB)"
  type        = number
}

variable "redis_sku_name" {
  description = "SKU for Redis Cache"
  type        = string
}

variable "redis_sku_family" {
  description = "SKU family of Redis Cache"
  type        = string
}

# Key Vault Variables
variable "redis_hostname_secret" {
  description = "Key Vault secret name to store Redis hostname"
  type        = string
}

variable "redis_primary_key_secret" {
  description = "Key Vault secret name to store Redis primary key"
  type        = string
}

# Git Personal Access Token (Sensitive for ACR Task)
variable "git_pat" {
  description = "GitHub Personal Access Token for accessing the repository"
  type        = string
  sensitive   = true
}

# ACI Variables
variable "aci_sku" {
  description = "SKU for Azure Container Instance"
  type        = string
}

variable "aci_cpu" {
  description = "CPU count for the container instance"
  type        = number
}

variable "aci_memory" {
  description = "Memory allocation for the container instance in GB"
  type        = number
}

variable "container_port" {
  description = "Port number to expose in the Azure Container Instance"
  type        = number
}

# ACR Variables
variable "acr_sku" {
  description = "SKU for Azure Container Registry"
  type        = string
}

variable "repository_url" {
  description = "URL of the GitHub repository containing the Docker image source"
  type        = string
}

variable "dockerfile_path" {
  description = "Path to docker file"
  type        = string
}

# AKS Variables
variable "node_pool_name" {
  description = "Node pool name for AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "node_vm_size" {
  description = "VM size for nodes in the AKS default node pool"
  type        = string
}

variable "os_disk_type" {
  description = "Disk type for nodes (Ephemeral or Managed)"
  type        = string
}

variable "keyvault_sku" {
  description = "SKU for the Azure Key Vault (standard or premium)"
  type        = string
}

variable "prefix" {
  description = "Name prefix"
  type        = string
}