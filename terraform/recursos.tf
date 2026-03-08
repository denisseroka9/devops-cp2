resource "azurerm_resource_group" "rg_cp2" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "casopractico2"
  }
}