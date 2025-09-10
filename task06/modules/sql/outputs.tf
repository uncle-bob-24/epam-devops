output "sql_connection_string" {
  value = format("Server=tcp:%s.database.windows.net,1433;Database=%s;User ID=%s;Password=%s;Trusted_Connection=False;Encrypt=True;",
    azurerm_mssql_server.mssql_server.fully_qualified_domain_name,
    azurerm_mssql_database.sql_database.name,
    var.sql_admin_name,
  random_password.sql_admin_password.result)
  sensitive = true
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
}