variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for ACR"
  type        = string
}

variable "location" {
  description = "Azure region where ACR will be created"
  type        = string
}

variable "acr_sku" {
  description = "SKU for Azure Container Registry (e.g., Basic, Standard, Premium)"
  type        = string
}

# GitHub repository configuration
variable "repository_url" {
  description = "URL of the source GitHub repository"
  type        = string
}

variable "dockerfile_path" {
  description = "The path to dockerfile"
  type        = string
}

variable "git_pat" {
  description = "GitHub Personal Access Token to access the source repository"
  type        = string
  sensitive   = true
}

# Docker image configuration
variable "docker_image_name" {
  description = "Name of the Docker image to be created in the Azure Container Registry"
  type        = string
}

variable "tags" {
  description = "Tags to associate with the resources"
  type        = map(string)
}