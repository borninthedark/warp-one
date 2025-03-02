resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  default_node_pool {
    name                 = var.agents_pool_name
    vm_size              = var.vm_size
    os_disk_size_gb      = var.os_disk_size_gb
    type                 = var.agents_type
    enable_auto_scaling  = var.enable_auto_scaling
    min_count            = var.agents_min_count
    max_count            = var.agents_max_count
    max_pods             = var.agents_max_pods
    availability_zones   = var.agents_availability_zones
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    dns_service_ip     = var.net_profile_dns_service_ip
    service_cidr       = var.net_profile_service_cidr
  }

  role_based_access_control_enabled = var.role_based_access_control_enabled

  azure_active_directory_role_based_access_control {
    managed = var.rbac_aad_managed
    azure_rbac_enabled = var.rbac_aad
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_enabled ? var.log_analytics_workspace_id : null
  }

  addon_profile {
    ingress_application_gateway {
      subnet_id = var.use_brown_field_application_gateway ? var.brown_field_application_gateway_for_ingress.subnet_id : var.green_field_application_gateway_for_ingress.subnet_id
    }
  }

  auto_upgrade_profile {
    upgrade_channel = var.automatic_channel_upgrade
  }

  local_account_disabled = var.local_account_disabled

  depends_on = [var.vnet_subnet_id]
}

# Attach ACR to AKS (Role Assignment for Pull Access)
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

