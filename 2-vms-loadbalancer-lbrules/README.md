# Azure-terraform-infra-test / 2-vms-loadbalancer-lbrules
Derived from Azure example terraform-providers/terraform-provider-azurerm/examples/2-vms-loadbalancer-lbrules/

This is a work in progress with Terraform and azurerm provider

- Add os_profile_windows_config that was required
- Add an output to list RDP access port for each created VM
- Variabilized VM count to be able to provision bigger LB

TODO :
- remove ssh output 
- Add a service on port 80
