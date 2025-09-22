# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = var.aks_name

  default_node_pool {
    name            = var.node_pool_name
    vm_size         = var.node_vm_size
    node_count      = var.node_count
    os_disk_type    = var.os_disk_type
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Add Role Assignment: Allow AKS to Pull from ACR
resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
}