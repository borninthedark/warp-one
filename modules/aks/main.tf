resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = var.node_count # ✅ Now correctly placed inside `default_node_pool`
    vm_size    = var.vm_size    # ✅ Now correctly placed inside `default_node_pool`
  }

  identity {
    type = "SystemAssigned"
  }

  ingress_application_gateway {
    subnet_id = var.appgw_subnet_id
  }

  role_based_access_control_enabled = var.rbac_enabled

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }
}

# Attach ACR to AKS (Role Assignment for Pull Access)
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

