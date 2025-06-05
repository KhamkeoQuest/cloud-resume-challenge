provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}


resource "azurerm_resource_group" "rg" {
  for_each = {
    dev   = var.locations["dev"]
    stage = var.locations["stage"]
    prod = var.locations["prod"]
  }

  name     = "rg-${var.project_name}-${each.key}"
  location = each.value

  tags = lookup(var.tags, each.key, {})
}

module "static_site" {
  source              = "./infra/modules/storage_static_site"
  project_name        = var.project_name
  environment         = "prod"
  resource_group_name = azurerm_resource_group.rg["prod"].name
  location            = azurerm_resource_group.rg["prod"].location
  tags                = var.tags["prod"]
  index_path          = local.index_path
  error_path          = local.error_path
  resume_path         = local.resume_path
}

