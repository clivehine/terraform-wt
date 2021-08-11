# Required resource variables
variable "vm_name" {
  description = "Name of vm"
  type        = string
}

variable "resource_group_name" {
  description = "Desired resource group name for the provisioned resources"
  type        = string
}

variable "resource_environment" {
  description = "Desired environment for the provisioned resources"
  type        = string
}

variable "resource_location" {
  description = "Desired location for the provisioned resources"
  type        = string
}

variable "vm_network_id" {
  description = "Virtual network ID for the provisioned resources"
  type        = string
}

variable "network_address" {
  description = "Network address space"
  type        = string
}

variable "vm_instance_count" {
  description = "Number of vms to deploy"
  type        = string
}

variable "location_zone_support" {
  description = "Whether the current location supports zones"
  type        = bool
}

/* variable "lb_services" {
  description = "All the lb services"
  type        = string
}

variable "lb_svc" {
  description = "Each lb service"
  type        = string
} */

/*
variable "ports" {
  description = "protocols and ports in pool in loadbalancer"
  type        = map(string)
  default = {
    "HTTPS" = "443"
    "HTTP"  = "80"
  }
}
*/
