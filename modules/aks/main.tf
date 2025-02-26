// main.tf for the aks module
// Define resources specific to aks here

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = var.dns_prefix
  kubernetes_version  = "1.25.6"

  default_node_pool {
    name       = "primary"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    ingress_application_gateway {
      enabled = true
    }
    azure_policy {
      enabled = true
    }
  }

  role_based_access_control {
    enabled = true
  }
}

output "name" {
  value = azurerm_kubernetes_cluster.aks.name
}
