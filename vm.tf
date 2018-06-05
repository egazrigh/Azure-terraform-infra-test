resource "azurerm_public_ip" "terraform-pip" {
  name                         = "${azurerm_resource_group.terraform-azure.name}-${var.vmname}-PublicIp1"
  resource_group_name          = "${azurerm_resource_group.terraform-azure.name}"
  public_ip_address_allocation = "static"
  location                     = "${var.location}"

  tags = "${local.common_tags}"
}

resource "azurerm_network_interface" "terraform-network_interface" {
  name                = "${azurerm_resource_group.terraform-azure.name}-${var.vmname}-nic"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.terraform-azure.name}"

  ip_configuration {
    name                          = "${azurerm_resource_group.terraform-azure.name}-${var.vmname}-ipconfig"
    subnet_id                     = "${azurerm_subnet.terraform-subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.terraform-pip.id}"
  }

  tags = "${local.common_tags}"
}

resource "azurerm_virtual_machine" "terraform-vm" {
  name                  = "${var.vmname}-vm"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.terraform-azure.name}"
  network_interface_ids = ["${azurerm_network_interface.terraform-network_interface.id}"]
  vm_size               = "Standard_A0"
  availability_set_id   = "${azurerm_availability_set.terraform-availability-set.id}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${var.vmname}-osdisk1"
    vhd_uri       = "${azurerm_storage_account.terraform-storage.primary_blob_endpoint}${azurerm_storage_container.terraform-container.name}/${var.vmname}-osdisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  storage_data_disk {
    name          = "${var.vmname}-datadisk0"
    vhd_uri       = "${azurerm_storage_account.terraform-storage.primary_blob_endpoint}${azurerm_storage_container.terraform-container.name}/${var.vmname}-datadisk0.vhd"
    disk_size_gb  = "1023"
    create_option = "Empty"
    lun           = 0
  }

  os_profile {
    computer_name  = "${var.vmname}"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = "${merge(
        local.common_tags,
        map(
          "Name", "awesome-app-server",
          "Role", "AnsibleServer"
        )
      )}"
}
