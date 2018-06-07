resource "azurerm_policy_definition" "test" {
  name         = "AuditAllowedLocation"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Audit Allowed Location"

  policy_rule = <<POLICY_RULE
    {
    "if": {
      "not": {
        "field": "location",
        "in": "[parameters('allowedLocations')]"
      }
    },
    "then": {
      "effect": "audit"
    }
  }
POLICY_RULE

  parameters = <<PARAMETERS
    {
    "allowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed locations for resources.",
        "displayName": "Allowed locations",
        "strongType": "location"
      }
    }
  }
PARAMETERS
}

resource "azurerm_policy_assignment" "test" {
  name                 = "example-policy-assignment"
  scope                = "${azurerm_resource_group.terra-rg.id}"
  policy_definition_id = "${azurerm_policy_definition.test.id}"
  description          = "This Policy Assignment audit that resource group is created in westeurope or francesouth"
  display_name         = "Audit RG Location in westeurope or francesouth"

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "westeurope", "francesouth" ]
  }
}
PARAMETERS
}

resource "azurerm_policy_assignment" "test2" {
  name                 = "example-policy-assignment2"
  scope                = "${azurerm_resource_group.terra-rg.id}"
  policy_definition_id = "${azurerm_policy_definition.test.id}"
  description          = "This Policy Assignment audit that resource group is created in northeurope"
  display_name         = "Audit RG Location in northeurope"

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "northeurope" ]
  }
}
PARAMETERS
}

resource "azurerm_policy_assignment" "test3" {
  name                 = "example-policy-assignment3"
  scope                = "${azurerm_resource_group.terra-rg.id}"
  policy_definition_id = "${azurerm_policy_definition.test.id}"
  description          = "This Policy Assignment audit that resource group is created in francecentral"
  display_name         = "Audit RG Location in francecentral"

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "francecentral" ]
  }
}
PARAMETERS
}
