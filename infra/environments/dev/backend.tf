terraform {
  backend "azurerm" {
    resource_group_name  = "rg-resume-dev"
    storage_account_name = "tfstatestoredeveastus2"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
