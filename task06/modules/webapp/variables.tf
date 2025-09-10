variable "app_service_plan_name" { type = string }
variable "app_service_plan_sku" { type = string }
variable "web_app_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "dotnet_version" { type = string }
variable "tags" { type = map(string) }
variable "sql_connection_string" {
  type      = string
  sensitive = true
}
variable "os_type" { type = string }