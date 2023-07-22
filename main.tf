


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
  
  # sku_name consists of 2 parts. First part is the name (consumption, premium etc), 2nd is the capacity (No of units).
  # Consumption plans are autoscaling, so always should be `0`.. All other Sku names must be a positive number.
  # Developer plans can only have 1 unit deployed.
  sku_name            = "${var.sku}_${(var.sku == "Consumption") ? 0 : ((var.sku == "Developer") ? 1 : var.skuCount)}"
  tags                = var.tags
  
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
