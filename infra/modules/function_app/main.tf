# Function App Storage Account (for code artifacts)

resource "azurerm_storage_account" "function_storage" {
  name                     = "sa${var.project_name}${var.environment}func"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = var.tags
}

# App Insights (monitoring)

resource "azurerm_application_insights" "appinsights" {
  name                = "ai-${var.project_name}-${var.environment}-${var.short_location}"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

# Consumption Plan

resource "azurerm_service_plan" "function_plan" {
  name                = "funcplan-${var.project_name}-${var.environment}-${var.short_location}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption plan
}

# The Function App itself

resource "azurerm_linux_function_app" "function_app" {
  name                       = "funcapp-${var.project_name}-${var.environment}-${var.short_location}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.function_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  functions_extension_version = "~4"

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }

  app_settings = {
    AzureWebJobsStorage      = azurerm_storage_account.function_storage.primary_connection_string
    FUNCTIONS_WORKER_RUNTIME = "python"
    COSMOS_DB_ENDPOINT       = var.cosmosdb_endpoint
    COSMOS_DB_KEY            = var.cosmosdb_primary_key
  }

  tags = var.tags
}
