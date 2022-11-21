
resource "azurerm_user_assigned_identity" "Level1Identity" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = "Level1Identity"
}

resource "azurerm_role_assignment" "RGOwner" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.Level1Identity.principal_id
}

resource "azurerm_role_assignment" "BlobContrib" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.Level1Identity.principal_id
}

