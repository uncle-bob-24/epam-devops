resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name # Dynamically generated from locals.tf
  location = var.region
  tags     = var.tags
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_resource_group_name
}

module "sql" {
  source                       = "./modules/sql"
  sql_server_name              = local.sql_server_name # Dynamically generated
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.region
  sql_db_name                  = local.sql_db_name # Dynamically generated
  sql_db_service_model         = var.sql_db_service_model
  sql_server_version           = var.sql_server_version
  allowed_ip_rule_name         = var.sql_firewall_rule_name
  allowed_ip_address           = var.allowed_ip_address
  sql_admin_name               = "admin_user" # Could be passed as a variable
  kv_id                        = data.azurerm_key_vault.kv.id
  kv_secret_sql_admin_name     = var.kv_secret_sql_admin_name
  kv_secret_sql_admin_password = var.kv_secret_sql_admin_password
  tags                         = var.tags
}

module "webapp" {
  source                = "./modules/webapp"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.region
  app_service_plan_name = local.asp_name # Dynamically generated
  app_service_plan_sku  = var.asp_sku
  os_type               = var.os_type
  web_app_name          = local.app_name # Dynamically generated
  dotnet_version        = var.dotnet_version
  sql_connection_string = module.sql.sql_connection_string
  tags                  = var.tags
}