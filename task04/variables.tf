variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "RG name"
}

variable "virtual_network_name" {
  type        = string
  description = "Vnet name"
}

variable "subnet1_name" {
  type        = string
  description = "sub1 name"
}

variable "nsg_name" {
  type        = string
  description = "nsg name"
}

variable "pip_name" {
  type        = string
  description = "pip name"
}

variable "dns_name_label" {
  type        = string
  description = "dns name label"
}

variable "vm_name" {
  type        = string
  description = "vm name"
}

variable "nic_name" {
  type        = string
  description = "nic name"
}

variable "ip_name" {
  type        = string
  description = "ip config name"
}

variable "nsg_rule1_name" {
  type        = string
  description = "nsg rule 1"
}

variable "nsg_rule2_name" {
  type        = string
  description = "nsg rule 2"
}

variable "admin_username" {
  type        = string
  description = "vm admin"
  sensitive   = true
}

variable "vm_password" {
  type        = string
  description = "vm password"
  sensitive   = true
}

variable "default_tag" {
  type = map(string)
  default = {
    Creator = "azamat_kireyev@epam.com"
  }
  description = "Default tag for resources"
}


  