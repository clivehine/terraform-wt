# Create network dependencies
module "vm_network" {
  source            = "../Network/"
  network_name      = var.network_name
  resource_location = var.resource_location
  network_address   = var.network_address
}
