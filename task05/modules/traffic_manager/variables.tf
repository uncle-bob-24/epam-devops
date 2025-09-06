variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "routing_method" {}
variable "dns_relative_name" {}
variable "dns_ttl" {}
variable "tags" {}
variable "endpoints" {
  type = map(object({
    name               = string
    target_resource_id = string
    endpoint_location  = string
    priority           = number
    weight             = number
  }))
}