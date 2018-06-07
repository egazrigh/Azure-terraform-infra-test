resource "azurerm_policy_definition" "ApplyTag" {
  name         = "ApplyTag"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Apply expected Tags"

  policy_rule = <<POLICY_RULE
{
  "if": {
    "allOf": [
      {
        "field": "[concat('tags[', parameters('tagName'), ']')]",
        "exists": "false"
      },
      {
        "field": "type",
        "equals": "Microsoft.Resources/subscriptions/resourceGroups"
      }
    ]
  },
  "then": {
    "effect": "append",
    "details": [
      {
        "field": "[concat('tags[', parameters('tagName'), ']')]",
        "value": "[parameters('tagValue')]"
      }
    ]
  }
}
POLICY_RULE

  parameters = <<PARAMETERS
{
	"tagName": {
		"type": "String",
		"metadata": {
			"description": "Name of the tag, such as costCenter"
		}
	},
	"tagValue": {
		"type": "String",
		"metadata": {
			"description": "Value of the tag, such as headquarter"
		}
	}
}

PARAMETERS
}

resource "azurerm_policy_assignment" "assigntag1" {
  name                 = "example-policy-assigntag1"
  scope                = "${azurerm_resource_group.terra-rg.id}"
  policy_definition_id = "${azurerm_policy_definition.ApplyTag.id}"
  description          = "Apply Owner tag"
  display_name         = "Apply Owner tag"

  parameters = <<PARAMETERS
{
  "tagName": {
    "value": 
      "Owner"
  },
  "tagValue": {
    "value": 
      "Eric34"
  }
}
PARAMETERS
}

resource "azurerm_policy_assignment" "assigntag2" {
  name                 = "example-policy-assigntag2"
  scope                = "${azurerm_resource_group.terra-rg.id}"
  policy_definition_id = "${azurerm_policy_definition.ApplyTag.id}"
  description          = "Apply Billing tag"
  display_name         = "Apply Billing tag"

  parameters = <<PARAMETERS
{
  "tagName": {
    "value": 
      "Billing"
  },
  "tagValue": {
    "value": 
      "BIL-99999"
  }
}
PARAMETERS
}
