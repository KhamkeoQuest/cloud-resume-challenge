# This file defines local variables for location normalization in Azure.
locals {
  location_mapping = {
    "East US"     = "eastus"
    "East US 2"   = "eastus2"
    "Central US"  = "centralus"
    "West US"     = "westus"
    "West US 2"   = "westus2"
    "West US 3"   = "westus3"
    "North Europe" = "northeurope"
    "West Europe"  = "westeurope"
  }

  short_location = lookup(local.location_mapping, var.location, replace(lower(var.location), " ", ""))
}
