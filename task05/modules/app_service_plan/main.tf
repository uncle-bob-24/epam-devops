resource "azurerm_service_plan" "asp" {
  for_each = var.app_service_plans

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku_name            = each.value.sku_size
  os_type             = each.value.os_type
  worker_count        = each.value.worker_count


  tags = each.value.tags
}