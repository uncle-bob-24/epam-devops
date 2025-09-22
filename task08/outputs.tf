# Output: Fully Qualified Domain Name (FQDN) of the Azure Container Instance
output "aci_fqdn" {
  description = "FQDN of the Azure Container Instance (ACI)"
  value       = module.aci.aci_fqdn
  sensitive   = false # This is safe to expose as it's publicly accessible
}

/*
# Output: LoadBalancer IP using the manifest
output "aks_lb_ip" {
  description = "LoadBalancer IP address of the app deployed in AKS"
  value       = data.kubernetes_service.service.status.0.load_balancer.0.ingress.0.ip
  sensitive   = false
}
*/
