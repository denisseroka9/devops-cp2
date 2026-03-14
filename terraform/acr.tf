resource "azurerm_container_registry" "acr_cp2" {
  name                = "acrcp2denisse"
  resource_group_name = azurerm_resource_group.rg_cp2.name
  location            = azurerm_resource_group.rg_cp2.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    environment = "casopractico2"
  }
}