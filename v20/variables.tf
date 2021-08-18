variable "resource_group" {
  description = "Name of resource group"
  type        = string
  default     = "VirtualMachineGroup"
}

variable "resource_location" {
  description = "Location of resources"
  type        = list(string)
  default = [
    "UK South",
    # "North Central US"
  ]
}

variable "vm_name" {
  description = "Name of vm"
  type        = string
  default     = "VM"
}

variable "vm_size" {
  description = "Size of vm"
  type        = string
  default     = "Standard_B1s"
}

variable "vm_instance_count" {
  description = "Number of vms to deploy"
  type        = string
  default     = 1
}

variable "network_address" {
  description = "Network address space"
  type        = map(string)
  default = {
    "UK South"         = "10.0.0.0/22"
    "North Europe"     = "10.1.0.0/22"
    "North Central US" = "10.2.0.0/22"
  }
}

variable "vm_data_disk_count" {
  description = "Desired size for the provisioned resources for each service"
  type        = number
  default     = 1
}

variable "vm_data_disk_size" {
  description = "Desired disk size for the provisioned data disk resources"
  type        = number
  default     = 32
}

/* variable "lb_services" {
  description = "services on lb"
  type        = map(string)
  default = {
    "HTTPS" = "443"
    "HTTP"  = "80"
  }
} */

#variable "lb_svc" {
#  description = "lb service placeholder"
#}