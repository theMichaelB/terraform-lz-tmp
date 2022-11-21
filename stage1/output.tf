output rgname {
    value = azurerm_resource_group.rg.name
}
output rglocation {
    value = azurerm_resource_group.rg.location
}
output subnet1 {
    value = azurerm_subnet.subnet1.id
}

output storageid {
    value = azurerm_storage_account.private.id
}