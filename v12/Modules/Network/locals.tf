locals {
  location_prefix = replace(var.resource_location, "/[a-z[:space:]]/", "")
  resource_group  = "${var.resource_group}-${local.location_prefix}"
}
