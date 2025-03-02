resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  # Node pool
  default_node_pool {
    name                  = var.agents_pool_name
    vm_size               = var.vm_size
    os_disk_size_gb       = var.os_disk_size_gb
    type                  = var.agents_type
    availability_zones    = var.agents_availability_zones
    enable_auto_scaling   = var.enable_auto_scaling
    min_count             = var.agents_min_count
    max_count             = var.agents_max_count
    max_pods             = var.agents_max_pods
    vnet_subnet_id       = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  # Ingress Application Gateway 
  ingress_application_gateway {
    subnet_id      = var.appgw_subnet_id
    public_ip_id   = var.appgw_public_ip_id 
  }

  # Azure RBAC / AAD config
  role_based_access_control_enabled = var.role_based_access_control_enabled
  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = var.rbac_aad
  }

  # Log Analytics Integration
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_enabled ? var.log_analytics_workspace_id : null
  }

  tags = {
    Environment = "Production"
  }
}

# Attach ACR to AKS (Role Assignment for Pull Access)
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

