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
}