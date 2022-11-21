
# Create Network Security Group and rule
resource "azurerm_network_security_group" "level1vm-nsg" {
  name                = "level1vm-sg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "level1vm-nic" {
  name                = "level1vm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.level1vm-ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.level1vm-nic.id
  network_security_group_id = azurerm_network_security_group.level1vm-nsg.id
}



# Create virtual machine
resource "azurerm_linux_virtual_machine" "level1vm" {
  name                  = "level1vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.level1vm-nic.id]
  size                  = "Standard_B2s"

  os_disk {
    name                 = "level1vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "Canonical"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "level1vm"
  admin_username                  = "ubuntu"
  disable_password_authentication = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.Level1Identity.id]
  }

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("/home/ubuntu/.ssh/ansible.pub")
  }

}