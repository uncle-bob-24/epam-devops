locals {

  # Dynamically generated resource names
  rg_name           = format("%s-rg", var.prefix)
  redis_name        = format("%s-redis", var.prefix)
  keyvault_name     = format("%s-kv", var.prefix)
  acr_name          = format("%scr", replace(var.prefix, "-", ""))
  docker_image_name = format("%s-app", var.prefix)
  aci_name          = format("%s-ci", var.prefix)
  dns_name_label    = format("%s-dns", var.prefix)
  aks_name          = format("%s-aks", var.prefix)

}