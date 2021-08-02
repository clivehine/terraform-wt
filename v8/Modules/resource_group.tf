# Create resource group
resource "azurerm_resource_group" "vm_group" {
  name     = "${var.resource_group}${var.deployment}"
  location = var.resource_location
}