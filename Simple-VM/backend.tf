terraform {
  backend "azurerm" {
    storage_account_name = "terratfstateseric51537"
    container_name       = "tfstates"
    resource_group_name  = "rg-for-shared-tfstates"
    key                  = "newproject.terraform.tfstate" #Configure first part to match the project name
  }
}
