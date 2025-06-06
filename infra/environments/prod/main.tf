terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0.0"
}

module "shared" {
  source = "../../shared"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${module.shared.project_name}-prod"
  location = module.shared.locations["prod"]
  tags     = module.shared.tags["prod"]
}

module "static_site" {
  source              = "../../modules/storage_static_site"
  project_name        = module.shared.project_name
  environment         = "prod"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = module.shared.tags["prod"]
  index_path          = module.shared.index_path
  error_path          = module.shared.error_path
  resume_path         = module.shared.resume_path
}
