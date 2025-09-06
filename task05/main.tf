module "resource_groups" {
  source = "./modules/resource_group"

  resource_groups = var.resource_groups
}

module "app_service_plans" {
  source = "./modules/app_service_plan"

  app_service_plans = var.app_service_plans
  depends_on        = [module.resource_groups]
}

module "web_apps" {
  source = "./modules/app_service"

  web_apps   = var.web_apps
  depends_on = [module.app_service_plans]
}

module "traffic_manager" {
  source = "./modules/traffic_manager"

  name                = var.traffic_manager.name
  location            = var.traffic_manager.location
  resource_group_name = var.traffic_manager.resource_group_name
  routing_method      = var.traffic_manager.routing_method
  dns_relative_name   = var.traffic_manager.dns_relative_name
  dns_ttl             = var.traffic_manager.dns_ttl
  tags                = var.traffic_manager.tags
  endpoints           = var.traffic_manager.endpoints

  depends_on = [module.web_apps]
}