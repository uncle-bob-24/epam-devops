variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location"
  type        = string
}

variable "sql_db_name" {
  description = "The name of the SQL Database"
  type        = string
}

variable "sql_db_service_model" {
  description = "The SKU model for the SQL Database"
  type        = string
}

variable "sql_server_version" {
  description = "SQL Server version to be used"
  type        = string
}

variable "sql_admin_name" {
  description = "The SQL administrator login username"
  type        = string
}

variable "kv_id" {
  description = "Key Vault ID for storing secrets"
  type        = string
}

variable "kv_secret_sql_admin_name" {
  description = "Key Vault secret name for SQL Admin username"
  type        = string
}

variable "kv_secret_sql_admin_password" {
  description = "Key Vault secret name for SQL Admin password"
  type        = string
}

variable "allowed_ip_rule_name" {
  description = "The name of the SQL Firewall rule for allowed IP"
  type        = string
}

variable "allowed_ip_address" {
  description = "The IP address to allow connections"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}