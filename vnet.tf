resource "azurerm_virtual_network" "terraform-vnet" {
  name                = "${azurerm_resource_group.terraform-azure.name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform-azure.name}"

  tags = "${local.common_tags}"
}

resource "azurerm_network_security_group" "terraform-nsg" {
  name                = "${azurerm_resource_group.terraform-azure.name}-nsg"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform-azure.name}"

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = "${local.common_tags}"
}

resource "azurerm_subnet" "terraform-subnet" {
  name                      = "${azurerm_resource_group.terraform-azure.name}-subnet"
  resource_group_name       = "${azurerm_resource_group.terraform-azure.name}"
  virtual_network_name      = "${azurerm_virtual_network.terraform-vnet.name}"
  address_prefix            = "10.0.2.0/24"
  network_security_group_id = "${azurerm_network_security_group.terraform-nsg.id}"
}

resource "azurerm_availability_set" "terraform-availability-set" {
  name                = "${azurerm_resource_group.terraform-azure.name}-availabilityset"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform-azure.name}"

  tags = "${local.common_tags}"
}
