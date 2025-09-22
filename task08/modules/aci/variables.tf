variable "aci_name" {
  description = "Name of Azure Container Instance"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Container Instance is deployed"
  type        = string
}

variable "location" {
  description = "Azure region for Azure Container Instance deployment"
  type        = string
}

variable "aci_sku" {
  description = "SKU for Azure Container Instance (e.g., Standard)"
  type        = string
}

variable "container_name" {
  description = "Name of the container inside the Azure Container Instance"
  type        = string
}

variable "container_image" {
  description = "Docker image used to build the container (e.g., from ACR)"
  type        = string
}

variable "cpu" {
  description = "Number of CPU cores for the container instance"
  type        = number
}

variable "memory" {
  description = "Memory in GB for the container instance"
  type        = number
}

variable "container_port" {
  description = "Port number exposed for external access"
  type        = number
}

variable "dns_name_label" {
  description = "DNS name label for the Azure Container Instance (must be globally unique)"
  type        = string
}

# Redis Integration - Secure environment variables
variable "redis_url" {
  description = "Redis hostname"
  type        = string
  sensitive   = true
}

variable "redis_pwd" {
  description = "Redis primary key credential"
  type        = string
  sensitive   = true
}

# ACR Integration - Docker authentication
variable "acr_login_server" {
  description = "Azure Container Registry login server (e.g., <acr_name>.azurecr.io)"
  type        = string
}

variable "acr_username" {
  description = "Azure Container Registry username"
  type        = string
}

variable "acr_password" {
  description = "Azure Container Registry password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the Azure Container Instance"
  type        = map(string)
}