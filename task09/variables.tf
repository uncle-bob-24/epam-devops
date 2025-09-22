variable "prefix" {
  description = "Unique identifier for resource naming"
  type        = string
}

variable "vnet_space" {
  description = "Existing Virtual Network Address Space"
  type        = string
}

variable "subnet_name" {
  description = "Existing Subnet name (AKS Cluster subnet)"
  type        = string
}

variable "subnet_space" {
  description = "Existing Subnet Address Space (AKS Cluster subnet)"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "AKS load-balancer public IP address"
  type        = string
}
