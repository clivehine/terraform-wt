# Create production virtual machines
module "vm_deployment" {
  for_each          = toset(var.resource_location)
  source            = "./Modules/"
  vm_name           = var.vm_name
  vm_instance_count = var.vm_instance_count
  vm_size           = var.vm_size
  resource_location = each.value
  deployment        = format("%02d", index(var.resource_location, each.value) + 1)
  network_address   = lookup(var.network_address, each.value, null)
}
