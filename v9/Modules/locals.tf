locals {
  location_prefix = replace(var.resource_location, "/[a-z[:space:]]/", "")
  resource_group  = "${var.resource_group}-${replace(var.resource_location, "/[a-z[:space:]]/", "")}"
  vm_name         = "${var.vm_name}-${local.location_prefix}"
}