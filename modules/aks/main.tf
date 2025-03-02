resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.aks_subnet_id  
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"  
    network_policy = "calico"
  }

  ingress_application_gateway {
    enabled   = true
    subnet_id = var.appgw_subnet_id  
  }

  depends_on = [var.appgw_subnet_id]
}

# Attach ACR to AKS (Role Assignment for Pull Access)
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

