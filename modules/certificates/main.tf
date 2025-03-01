resource "azurerm_key_vault_certificate" "ssl_cert" {
  name         = var.ssl_certificate_name
  key_vault_id = var.key_vault_id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }
      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage           = ["digitalSignature", "keyEncipherment"]
      subject             = "CN=${var.domain_name}"
      validity_in_months  = var.validity_in_months
    }
  }

  depends_on = [var.key_vault_id] 
}

# Assign permissions to AKS and Application Gateway
resource "azurerm_role_assignment" "aks_cert_reader" {
  scope                = var.key_vault_id
  role_definition_name = "Reader"
  principal_id         = var.aks_managed_identity_id

  depends_on = [azurerm_key_vault_certificate.ssl_cert] 
}

resource "azurerm_role_assignment" "appgw_cert_reader" {
  scope                = var.key_vault_id
  role_definition_name = "Reader"
  principal_id         = var.appgw_managed_identity_id

  depends_on = [azurerm_key_vault_certificate.ssl_cert] 
}

output "certificate_secret_id" {
  description = "The Secret ID of the SSL Certificate in Key Vault."
  value       = azurerm_key_vault_certificate.ssl_cert.secret_id
}
