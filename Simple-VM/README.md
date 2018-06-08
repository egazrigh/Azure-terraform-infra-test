# Azure-terraform-infra-test
Based onto a fork of EtienneDeneuve/Azure Work

This is a work in progress with Terraform and azurerm provider

- Split code into multiple files
- Implement a terraform backend using an Azure Storage group
- Define common tags that are applied to all created resources
- Add random value to storage group name to avoid conflicts
