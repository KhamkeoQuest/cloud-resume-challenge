# dev/main.tf

module "shared" {
  source          = "../../shared"
  subscription_id = var.subscription_id
}


# This file sets up the development environment for the Cloud Resume Challenge using Azure resources.
locals {
  frontend_path = "${path.root}/../../../frontend"
  index_path    = "${local.frontend_path}/index.html"
  error_path    = "${local.frontend_path}/404.html"
  resume_path   = "${local.frontend_path}/khamkeo_khongsaly_resume.html"
}

# This file sets up the development environment for the Cloud Resume Challenge using Azure resources.
resource "azurerm_resource_group" "rg" {
  name     = "rg-${module.shared.project_name}-${var.environment}"
  location = module.shared.locations[var.environment]
  tags     = module.shared.tags[var.environment]
}

# This module normalizes the location input to a format suitable for Azure resources.
module "normalized_location" {
  source              = "../../modules/location_normalizer"
  location            = module.shared.locations[var.environment]
}

# This module sets up an Azure Resource Group for the Cloud Resume Challenge.
resource "azurerm_application_insights" "app_insights" {
  name                = "ai-${module.shared.project_name}-${var.environment}-${module.normalized_location.short_location}"
  location            = module.shared.locations[var.environment]
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

# This module sets up an Azure Static Web App to host the frontend of the cloud resume challenge.
module "static_storage" {
  source              = "../../modules/storage_static_site"
  project_name        = module.shared.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = module.shared.locations[var.environment]
  tags                = module.shared.tags[var.environment]
  index_path          = local.index_path
  error_path          = local.error_path
  resume_path         = local.resume_path
}

# This module sets up an Azure Static Web App to host the frontend of the cloud resume challenge.
module "static_web_app" {
  source              = "../../modules/static_web_app"
  project_name        = module.shared.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = module.shared.locations[var.environment]
  tags                = module.shared.tags[var.environment]
}


# This module sets up an Azure Cosmos DB account with serverless capabilities, a SQL database named "resume",
# and a container named "visitorCounter" with a partition key on the "id" field.
module "cosmosdb" {
  source              = "../../modules/cosmosdb"
  project_name        = module.shared.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = module.shared.locations[var.environment]
  tags                = module.shared.tags[var.environment]
  short_location      = module.normalized_location.short_location
}

# This module creates an Azure Function App with a consumption plan, storage account, and Application Insights.
module "function_app" {
  source                  = "../../modules/function_app"
  project_name            = module.shared.project_name
  environment             = var.environment
  resource_group_name     = azurerm_resource_group.rg.name
  location                = module.shared.locations[var.environment]
  tags                    = module.shared.tags[var.environment]
  cosmosdb_endpoint       = module.cosmosdb.cosmosdb_endpoint
  cosmosdb_primary_key    = module.cosmosdb.cosmosdb_primary_key
  short_location          = module.normalized_location.short_location
}














# no longer needed as we are going to use Azure Cosmos DB for the visitor counter
# This module sets up an Azure Cosmos DB account with serverless capabilities, a SQL database named "resume",
# and a container named "visitorCounter" with a partition key on the "id" field.
module "storage_account" {
  source              = "../../modules/storage_account"
  count               = 0 # setting count to 0 to avoid creating storage account for table storage in dev environment
  project_name        = module.shared.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = module.shared.locations[var.environment]
  tags                = module.shared.tags[var.environment]
}


# This module sets up an Azure CDN profile and endpoint for serving static content from Azure Blob Storage.
# setting count to 0 to avoid creating CDN in dev environment
# keep code here in case we want to enable CDN in the future
module "cdn" {
  source              = "../../modules/cdn"
  count               =  0
  project_name        = module.shared.project_name
  environment         = var.environment
  location            = module.shared.locations[var.environment]
  resource_group_name = azurerm_resource_group.rg.name
  tags                = module.shared.tags[var.environment]

  # Pulling output from the storage module
  blob_primary_web_host = module.static_storage.primary_web_host
}
