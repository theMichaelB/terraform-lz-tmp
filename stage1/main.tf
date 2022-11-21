/*
This module creates an enclosed vnet to allow for 



*/



resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = {
    Owner = "theMichaelB"
  }
}