resource "azurerm_virtual_network" "vnet_cp2" {
  name                = "vnet-cp2"
  location            = azurerm_resource_group.rg_cp2.location
  resource_group_name = azurerm_resource_group.rg_cp2.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_subnet" "subnet_cp2" {
  name                 = "subnet-cp2"
  resource_group_name  = azurerm_resource_group.rg_cp2.name
  virtual_network_name = azurerm_virtual_network.vnet_cp2.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg_cp2" {
  name                = "nsg-cp2"
  location            = azurerm_resource_group.rg_cp2.location
  resource_group_name = azurerm_resource_group.rg_cp2.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_public_ip" "public_ip_cp2" {
  name                = "public-ip-cp2"
  location            = azurerm_resource_group.rg_cp2.location
  resource_group_name = azurerm_resource_group.rg_cp2.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_network_interface" "nic_cp2" {
  name                = "nic-cp2"
  location            = azurerm_resource_group.rg_cp2.location
  resource_group_name = azurerm_resource_group.rg_cp2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_cp2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_cp2.id
  }

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic_cp2.id
  network_security_group_id = azurerm_network_security_group.nsg_cp2.id
}