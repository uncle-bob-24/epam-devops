locals {
  # Common prefix for resource naming
  prefix = "cmaz-65725fc3-mod6"

  # Dynamically constructed names with the prefix
  rg_name         = format("%s-rg", local.prefix)
  sql_server_name = format("%s-sql", local.prefix)
  sql_db_name     = format("%s-sql-db", local.prefix)
  asp_name        = format("%s-asp", local.prefix)
  app_name        = format("%s-app", local.prefix)
}