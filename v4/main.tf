terraform {
  required_version = ">= 1.0.1"
}


#!new code
data "azurerm_client_config" "current" {}

data "azurerm_subscription" "example" {
#  id = "CAF-blueprint-example"
}

data "azurerm_blueprint_definition" "example" {
# name     = "exampleBlueprint"
  name     = "CAF-bp-full"
  scope_id = data.azurerm_subscription.example.id
}

data "azurerm_blueprint_published_version" "example" {
  scope_id       = data.azurerm_blueprint_definition.example.scope_id
  blueprint_name = data.azurerm_blueprint_definition.example.name
# version        = "v1.0.0"
  version        = "0.1"
}

# Duplicate !! 
#resource "azurerm_resource_group" "example" {
#  name     = "exampleRG-bp"
#  location = "West Europe"
#
#  tags = {
#    Environment = "example"
#  }
#}
#

resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = azurerm_resource_group.vm_group.name
  location            = azurerm_resource_group.vm_group.location
  name                = "bp-user-example"
}

resource "azurerm_role_assignment" "operator" {
  scope                = data.azurerm_subscription.example.id
  role_definition_name = "Blueprint Operator"
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}

resource "azurerm_role_assignment" "owner" {
  scope                = data.azurerm_subscription.example.id
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}

resource "azurerm_blueprint_assignment" "example" {
  name                   = "testAccBPAssignment"
  target_subscription_id = data.azurerm_subscription.example.id
  version_id             = data.azurerm_blueprint_published_version.example.id
  location               = azurerm_resource_group.vm_group.location

  lock_mode = "AllResourcesDoNotDelete"

  lock_exclude_principals = [
    data.azurerm_client_config.current.object_id,
  ]

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }

  resource_groups = <<GROUPS
    {
      "ResourceGroup": {
        "name": "exampleRG-bp"
      }
    }
  GROUPS

  parameter_values = <<VALUES
    {
      "Allowed locations for resource groups": {
        "value": ["westus", "eastus", "centralus", "northcentralus", "northeurope", "westeurope", "uknorth", "uksouth2", "uksouth", "ukwest"]
      }
    }
  VALUES
  # "value": ["westus", "westus2", "eastus", "centralus", "centraluseuap", "southcentralus", "northcentralus", "westcentralus", "eastus2", "eastus2euap", "brazilsouth", "brazilus", "northeurope", "westeurope", "eastasia", "southeastasia", "japanwest", "japaneast", "koreacentral", "koreasouth", "indiasouth", "indiawest", "indiacentral", "australiaeast", "australiasoutheast", "canadacentral", "canadaeast", "uknorth", "uksouth2", "uksouth", "ukwest", "francecentral", "francesouth", "australiacentral", "australiacentral2", "uaecentral", "uaenorth", "southafricanorth", "southafricawest", "switzerlandnorth", "switzerlandwest", "germanynorth", "germanywestcentral", "norwayeast", "norwaywest"]
      
  depends_on = [
    azurerm_role_assignment.operator,
    azurerm_role_assignment.owner
  ]
}
