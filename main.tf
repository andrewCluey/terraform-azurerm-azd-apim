


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
