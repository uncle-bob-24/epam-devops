variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
  description = "A map of resource groups with their name, location, and tags."
}

variable "app_service_plans" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku_tier            = string
    sku_size            = string
    worker_count        = number
    os_type             = string
    tags                = map(string)
  }))
  description = "A map of App Service Plans with their properties."
}

variable "web_apps" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    app_service_plan_id = string
    ip_restrictions = list(object({
      name     = string
      type     = string
      value    = string
      priority = number
    }))
    tags = map(string)
  }))
  description = "A map of Windows App Services with their properties and IP restrictions."
}

variable "traffic_manager" {
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    routing_method      = string
    dns_relative_name   = string
    dns_ttl             = number
    tags                = map(string)
    endpoints = map(object({
      name               = string
      target_resource_id = string
      endpoint_location  = string
      priority           = number
      weight             = number
    }))
  })
  description = "Traffic Manager configuration with routing properties and endpoints."
}