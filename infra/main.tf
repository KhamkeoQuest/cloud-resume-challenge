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
    prod1 = var.locations["prod1"]
    prod2 = var.locations["prod2"]
  }

  name     = "rg-${var.project_name}-${each.key}"
  location = each.value

  tags = lookup(var.tags, (
    contains(["prod1", "prod2"], each.key) ? "prod" : each.key
  ), {})
}
