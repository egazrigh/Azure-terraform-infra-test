resource "random_integer" "sto" {
  min = 1
  max = 99999
}

resource "azurerm_storage_account" "terraform-storage" {
  name                = "${var.projectname}sa${random_integer.sto.result}"
  resource_group_name = "${azurerm_resource_group.terraform-azure.name}"

  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = "${local.common_tags}"
}

resource "azurerm_storage_container" "terraform-container" {
  name                  = "vhds"
  resource_group_name   = "${azurerm_resource_group.terraform-azure.name}"
  storage_account_name  = "${azurerm_storage_account.terraform-storage.name}"
  container_access_type = "private"
}
