data "azurerm_client_config" "current" {}

# Create Azure Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku
  tenant_id    = data.azurerm_client_config.current.tenant_id

  purge_protection_enabled = false

  tags = var.tags
}

# Access Policy: Full access for the current user
resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
}

# Access Policy: Allow AKS-managed identity to retrieve Redis secrets
resource "azurerm_key_vault_access_policy" "aks_access" {
  key_vault_id = azurerm_key_vault.keyvault.id

  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id = var.aks_identity_object_id

  secret_permissions = ["Get"] # Provide access to retrieve Redis secrets
}