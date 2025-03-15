resource "azurerm_kubernetes_cluster" "aks" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.dns_prefix
  kubernetes_version        = var.kubernetes_version
  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled


  api_server_access_profile {
    authorized_ip_ranges = ["146.70.202.188/24"]
  }

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
  }

  # Node pool
  default_node_pool {
    name                 = var.agents_pool_name
    auto_scaling_enabled = var.auto_scaling_enabled
    vm_size              = var.vm_size
    os_disk_size_gb      = var.os_disk_size_gb
    type                 = var.agents_type
    min_count            = var.agents_min_count
    max_count            = var.agents_max_count
    max_pods             = var.agents_max_pods
    vnet_subnet_id       = var.aks_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  # Ingress Application Gateway 
  ingress_application_gateway {
    subnet_id = var.appgw_subnet_id
  }

  # Azure RBAC / AAD config
  azure_active_directory_role_based_access_control {
    azure_rbac_enabled     = true
    tenant_id              = var.tenant_id
    admin_group_object_ids = var.admin_group
  }

  tags = {
    environment = local.environment
    project     = "phoenix"
  }
}

# Attach ACR to AKS (Role Assignment for Pull Access)
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

