# stage/main.tf

module "shared" {
  source = "../../shared"
}

locals {
  frontend_path = "${path.root}/../../../frontend"
  index_path    = "${local.frontend_path}/index.html"
  error_path    = "${local.frontend_path}/404.html"
  resume_path   = "${local.frontend_path}/khamkeo_khongsaly_resume.html"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${module.shared.project_name}-${var.environment}"
  location = module.shared.locations[var.environment]
  tags     = module.shared.tags[var.environment]
}

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

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-resume-stage"
    storage_account_name = "stresumestage"
    container_name       = "tfstate"
    key                  = "stage.terraform.tfstate"

  }
}

module "cdn" {
  source              = "../../modules/cdn"
  project_name        = module.shared.project_name
  environment         = var.environment
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = module.shared.tags[var.environment]

  # Pulling output from the storage module
  blob_primary_web_host = module.static_storage.primary_web_host
}
