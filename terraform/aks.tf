resource "azurerm_kubernetes_cluster" "aks_cp2" {
  name                = "aks-cp2"
  location            = azurerm_resource_group.rg_cp2.location
  resource_group_name = azurerm_resource_group.rg_cp2.name
  dns_prefix          = "akscp2"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks_cp2.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr_cp2.id
}