variable "name_prefix" {
  description = "Prefix name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "acr_sku" {
  description = "Azure Container Registry sku"
  type        = string
  default     = "Basic"
}

variable "git_pat" {
  description = "Personal access token for git repository"
  type        = string
  sensitive   = true
}

variable "git_repo_url" {
  description = "Git repository URL"
  type        = string
}