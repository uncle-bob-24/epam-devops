output "aci_fqdn" {
  description = "Azure Container Instance FQDN"
  value       = module.aci.aci_fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address"
  value       = data.kubernetes_service.app_service.status.0.load_balancer.0.ingress.0.ip
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.acr.acr_login_server
}