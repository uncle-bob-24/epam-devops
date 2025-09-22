# Cluster Credentials for Kubernetes CLI (kubectl)
output "kube_config" {
  description = "The kube_config generated for access to the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

# Managed Kubernetes Cluster Hostname
output "aks_fqdn" {
  description = "The FQDN of the AKS cluster API"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_user_object_id" {
  description = "Managed identity object ID for AKS to access Key Vault"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}