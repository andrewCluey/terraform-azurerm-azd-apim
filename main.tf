


# ------------------------------------------------------------------------------------------------------
# Deploy api management service
# ------------------------------------------------------------------------------------------------------

# Create a new APIM instance
resource "azurerm_api_management" "main" { 
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  tags                = var.tags
  sku_name            = "${var.sku}_${(var.sku == "Consumption") ? 0 : ((var.sku == "Developer") ? 1 : var.skuCount)}"
  
/*

  # Production grade customisation. Not defined for AZD templates.
  zones = [ "value" ]
  notification_sender_email = "value"
  gateway_disabled = false
  min_api_version = "value"
  
  protocols {enable_http2 = false}
  
  security {}

  sign_in {enabled = false}

  sign_up {
    enabled = false
    terms_of_service {}
  }

  tenant_access {enabled = false}

  public_ip_address_id = "value"
  public_network_access_enabled = false
  virtual_network_type = "value" # None / External / Internal. When Internal or External, ensure inbound port 3443 is open
  
  # Required if virtual_network_type is External or Internal
  virtual_network_configuration {
    subnet_id = "value"
  }

  additional_location {
    location = "value"
    capacity = 0
    zones = [ "value" ]
    public_ip_address_id = "value"
    gateway_disabled = false

    virtual_network_type = "None" # None / External / Internal. When Internal or External, ensure inbound port 3443 is open
    virtual_network_configuration {
      subnet_id = "value"
    }
  }

  client_certificate_enabled = false
  certificate {
    encoded_certificate = "value"
    store_name = "value"
    certificate_password = "value"
  }

  delegation {
    subscriptions_enabled = false
    user_registration_enabled = false
    url = "value"
    validation_key = "value"
  }

*/

  identity  {
    type = "SystemAssigned"
  }
}

# Create Logger
resource "azurerm_api_management_logger" "main" {
  name                  = "app-insights-logger"
  api_management_name   = azurerm_api_management.main.name
  resource_group_name   = var.rg_name
  
  application_insights {
    instrumentation_key = var.appinsights_instrumentation_key
  }
}
