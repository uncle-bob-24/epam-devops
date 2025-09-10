resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.sql_admin_name
  administrator_login_password = random_password.sql_admin_password.result
  version                      = var.sql_server_version
  tags                         = var.tags
}

resource "azurerm_mssql_database" "sql_database" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.mssql_server.id
  sku_name  = var.sql_db_service_model
  tags      = var.tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.mssql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "allow_verification_ip" {
  name             = var.allowed_ip_rule_name
  server_id        = azurerm_mssql_server.mssql_server.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

resource "azurerm_key_vault_secret" "sql_admin_name" {
  name         = var.kv_secret_sql_admin_name
  value        = var.sql_admin_name
  key_vault_id = var.kv_id
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.kv_secret_sql_admin_password
  value        = random_password.sql_admin_password.result
  key_vault_id = var.kv_id
}