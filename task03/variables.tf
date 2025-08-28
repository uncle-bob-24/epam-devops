variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "default_tag" {
  type = map(string)
  default = {
    Creator = "azamat_kireyev@epam.com"
  }
  description = "Default tag for resources"
}


  