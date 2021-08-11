# Define resource group for resource
resource "azurerm_resource_group" "vm_group" {
  name     = local.resource_group
  location = var.traffic_manager_location
}
