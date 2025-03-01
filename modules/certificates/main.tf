resource "azurerm_key_vault_certificate" "ssl_cert" {
  name         = var.ssl_certificate_name
  key_vault_id = var.key_vault_id

  certificate_policy {
    issuer_parameters {
      name = "Self"  # Change to "DigiCert" if using an external CA
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
}

