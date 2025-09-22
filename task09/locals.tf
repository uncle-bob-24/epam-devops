locals {
  rg_name             = format("%s-rg", var.prefix)
  vnet_name           = format("%s-vnet", var.prefix)

  fw_subnet_name   = "AzureFirewallSubnet"            # Required name for Azure Firewall subnet
  fw_subnet_prefix = cidrsubnet(var.vnet_space, 8, 1) # Creating a subnet for the firewall

}
