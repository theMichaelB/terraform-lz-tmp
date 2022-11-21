

data "terraform_remote_state" "state1" {
  backend = "local"

  config = {
    path = "../stage1/terraform.tfstate"
  }
}

resource "azurerm_storage_account" "private" {
  name                = "terraformprivategv11"
  resource_group_name = data.terraform_remote_state.state1.outputs.rgname

  location                  = data.terraform_remote_state.state1.outputs.rglocation
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "BlobStorage"
  shared_access_key_enabled = false
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [data.terraform_remote_state.state1.outputs.rglocation]
  }

  tags = {
    environment = "staging"
  }
}
