region                       = "West US"
sql_db_service_model         = "S2"
sql_server_version           = "12.0" # Use the required version based on Azure availability
sql_firewall_rule_name       = "allow-verification-ip"
asp_sku                      = "P0v3"
os_type                      = "Linux"
dotnet_version               = "8.0"
allowed_ip_address           = "18.153.146.156"
kv_resource_group_name       = "cmaz-65725fc3-mod6-kv-rg"
kv_name                      = "cmaz-65725fc3-mod6-kv"
kv_secret_sql_admin_name     = "sql-admin-name"
kv_secret_sql_admin_password = "sql-admin-password"
tags = {
  Creator = "azamat_kireyev@epam.com"
}