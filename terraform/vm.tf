resource "azurerm_linux_virtual_machine" "vm_cp2" {
  name                = "vm-cp2"
  resource_group_name = azurerm_resource_group.rg_cp2.name
  location            = azurerm_resource_group.rg_cp2.location
  size                = "Standard_D2s_v3"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.nic_cp2.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("/home/denisse/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "casopractico2"
  }
}