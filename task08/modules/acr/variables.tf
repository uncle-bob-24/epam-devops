variable "name" {
  description = "Name of the Container Registry"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku" {
  description = "SKU of the Container Registry"
  type        = string
  default     = "Basic"
}

variable "git_repo_url" {
  description = "Git repository URL"
  type        = string
}

variable "git_pat" {
  description = "Personal access token for git repository"
  type        = string
  sensitive   = true
}

variable "image_name" {
  description = "Name of the Docker image"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
