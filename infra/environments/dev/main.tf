# dev/main.tf

module "shared" {
  source = "../../shared"
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

# This module sets up an Azure Static Web App to host the frontend of the cloud resume challenge.
module "static_storage" {
  source              = "../../modules/storage_static_site"
  project_name        = module.shared.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = module.shared.tags[var.environment]
  index_path          = local.index_path
  error_path          = local.error_path
  resume_path         = local.resume_path
}

# This file sets up the development environment for the Cloud Resume Challenge using Azure resources.
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-resume-dev"
    storage_account_name = "stresumedev"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

# This module sets up an Azure Static Web App to host the frontend of the cloud resume challenge.
module "static_web_app" {
  source              = "../../modules/static_web_app"
  project_name        = module.shared.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = module.shared.tags[var.environment]
}

module "storage_account" {
  source              = "../../modules/storage_account"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
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
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = module.shared.tags[var.environment]

  # Pulling output from the storage module
  blob_primary_web_host = module.static_storage.primary_web_host
}
