provider "azurerm" {
  #credentials defined with set-credentials.bat as environmment variables like this : set ARM_SUBSCRIPTION_ID=  set ARM_CLIENT_ID= set ARM_TENANT_ID= set ARM_CLIENT_SECRET=
}

resource "azurerm_resource_group" "terra-rg" {
  name     = "Terra-rg"
  location = "francecentral"
}
