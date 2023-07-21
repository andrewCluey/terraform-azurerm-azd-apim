output "APIM_SERVICE_NAME" {
  value = azurerm_api_management.main.name
}

output "API_MANAGEMENT_LOGGER_ID" {
  value = azurerm_api_management_logger.main.id
}
