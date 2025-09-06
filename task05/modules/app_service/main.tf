resource "azurerm_windows_web_app" "app" {
  for_each = var.web_apps

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  service_plan_id     = each.value.app_service_plan_id

  site_config {
    always_on = true

    dynamic "ip_restriction" {
      for_each = each.value.ip_restrictions

      content {
        name        = ip_restriction.value.name
        action      = ip_restriction.value.action
        priority    = ip_restriction.value.priority
        ip_address  = ip_restriction.value.typ == "ip_address" ? ip_restriction.value.value : null
        service_tag = ip_restriction.value.typ == "service_tag" ? ip_restriction.value.value : null
      }
    }
  }

  tags = each.value.tags

}