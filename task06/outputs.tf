output "sql_server_fqdn" {
  value       = module.sql.sql_server_fqdn
  description = "SQL Server fqdn"
}

output "app_hostname" {
  value       = module.webapp.app_hostname
  description = "Webapp hostname"
}