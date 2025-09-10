output "sql_connection_string" {
  value = format(
    "Server=tcp:%s,1433;Initial Catalog=%s;Persist Security Info=False;User ID=%s;Password=%s;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
    azurerm_mssql_server.mssql_server.fully_qualified_domain_name, # {server_name}
    azurerm_mssql_database.sql_database.name,                      # {db_name}
    var.sql_admin_name,                                            # {sql_user_name}
    random_password.sql_admin_password.result                      # {sql_user_password}
  )
  sensitive = true # Marking the connection string as sensitive
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
}