# Create a resource group 
resource "azurerm_resource_group" "cmaz-65725fc3-mod3-rg" {
  location = var.resource_group_location
  name     = var.resource_group_name

  tags = var.default_tag
}

# Create a storage account
resource "azurerm_storage_account" "cmaz65725fc3sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.cmaz-65725fc3-mod3-rg.name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.default_tag
}

# Create a Vnet
resource "azurerm_virtual_network" "cmaz-65725fc3-mod3-vnet" {
  name                = var.virtual_network_name
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.cmaz-65725fc3-mod3-rg.name
  address_space       = ["10.0.0.0/16"]

  tags = var.default_tag
}

# Create subnet 1
resource "azurerm_subnet" "frontend" {
  name                 = var.subnet1_name
  resource_group_name  = azurerm_resource_group.cmaz-65725fc3-mod3-rg.name
  virtual_network_name = azurerm_virtual_network.cmaz-65725fc3-mod3-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create subnet 2
resource "azurerm_subnet" "backend" {
  name                 = var.subnet2_name
  resource_group_name  = azurerm_resource_group.cmaz-65725fc3-mod3-rg.name
  virtual_network_name = azurerm_virtual_network.cmaz-65725fc3-mod3-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}