variable "region" {
  description = "Azure region to deploy the resources"
  type        = string
}

variable "sql_db_service_model" {
  description = "SQL Database SKU model to be provisioned"
  type        = string
}

variable "sql_server_version" {
  description = "SQL Server version to be used for Azure SQL Server"
  type        = string
}

variable "os_type" {
  description = "Web App OS type"
  type        = string
}

variable "sql_firewall_rule_name" {
  description = "Name of the SQL Firewall Rule for verification IP"
  type        = string
}

variable "asp_sku" {
  description = "SKU for the App Service Plan"
  type        = string
}

variable "dotnet_version" {
  description = "Dotnet version for the Linux Web App"
  type        = string
}

variable "allowed_ip_address" {
  description = "Verification agent's IP address to allow access to SQL Server"
  type        = string
}

variable "kv_secret_sql_admin_name" {
  description = "Key Vault secret name where the SQL Admin username will be stored"
  type        = string
}

variable "kv_secret_sql_admin_password" {
  description = "Key Vault secret name where the SQL Admin password will be stored"
  type        = string
}

variable "kv_resource_group_name" {
  description = "Key Vault resource group - existing"
  type        = string
}

variable "kv_name" {
  description = "Key Vault name - existing"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}