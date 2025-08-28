variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "RG name"
}

variable "storage_account_name" {
  type        = string
  description = "SA name"
}

variable "virtual_network_name" {
  type        = string
  description = "Vnet name"
}

variable "subnet1_name" {
  type        = string
  description = "sub1 name"
}

variable "subnet2_name" {
  type        = string
  description = "sub2 name"
}

variable "default_tag" {
  type = map(string)
  default = {
    Creator = "azamat_kireyev@epam.com"
  }
  description = "Default tag for resources"
}


  