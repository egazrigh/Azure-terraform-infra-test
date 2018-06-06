output "hostname" {
  value = "${var.hostname}"
}

output "vm_fqdn" {
  value = "${azurerm_public_ip.lbpip.fqdn}"
}

output "ssh_command" {
  value = "ssh ${var.admin_username}@${azurerm_public_ip.lbpip.fqdn}"
}

output "VMs RDP acces" {
  value = "${formatlist("RDP_URL=%v:%v username=%v password=%v", azurerm_public_ip.lbpip.fqdn, azurerm_lb_nat_rule.tcp.*.frontend_port,var.admin_username,var.admin_password)}"
}
