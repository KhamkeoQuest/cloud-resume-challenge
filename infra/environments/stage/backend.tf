terraform {
  backend "azurerm" {
    resource_group_name  = "rg-resume-stage"
    storage_account_name = "tfstatestorestage"
    container_name       = "tfstate"
    key                  = "stage.terraform.tfstate"
  }
}
