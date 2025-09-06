output "resource_groups" {
  value = { for rg_name, rg in azurerm_resource_group.rg : rg_name => {
    name     = rg.name
    location = rg.location
  } }
}