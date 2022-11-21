
resource "azurerm_private_endpoint" "endpoint" {
  name                = "tfprivatev11"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet1.id

  private_service_connection {
    name                           = "privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.private.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

}

resource "azurerm_storage_account" "private" {
  name                = "terraformprivategv11"
  resource_group_name = azurerm_resource_group.rg.name
  allow_nested_items_to_be_public = false
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "BlobStorage"
  shared_access_key_enabled = false
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.subnet1.id]
  }

  tags = {
    environment = "staging"
  }
}

/*
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.private.name
  container_access_type = "private"
}
*/