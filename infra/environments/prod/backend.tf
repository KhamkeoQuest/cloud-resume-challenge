terraform {
  backend "azurerm" {
    resource_group_name  = "rg-resume-prod"
    storage_account_name = "tfstateresumeprod"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
