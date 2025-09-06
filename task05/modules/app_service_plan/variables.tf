variable "app_service_plans" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku_tier            = string
    sku_size            = string
    worker_count        = number
    os_type = string
    tags                = map(string)
  }))
}