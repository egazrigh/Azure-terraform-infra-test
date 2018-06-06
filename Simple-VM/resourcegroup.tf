resource "azurerm_resource_group" "terraform-azure" {
  name     = "${var.projectname}"
  location = "${var.location}"

  /*
      tags = "${merge(
        local.common_tags,
        map(
          "Name", "awesome-app-server",
          "Role", "server"
        )
      )}"

      */


  /*
  tags = "${merge(
    local.common_tags
  )}"
*/

  tags = "${local.common_tags}"
}
