# Create availability set
resource "azurerm_availability_set" "vm_availability_set" {
  name                        = local.vm_name
  location                    = azurerm_resource_group.vm_group.location
  resource_group_name         = azurerm_resource_group.vm_group.name
  platform_fault_domain_count = var.vm_fault_domain

  tags = {
    environment = var.vm_environment
  }
}

# Create network adapter
resource "azurerm_network_interface" "vm_network_interface" {
  count               = var.vm_instance_count
  name                = "${local.vm_name}${count.index + 1}"
  location            = azurerm_resource_group.vm_group.location
  resource_group_name = azurerm_resource_group.vm_group.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "virtual_machine" {
  count               = var.vm_instance_count
  name                = "${local.vm_name}${count.index + 1}"
  resource_group_name = azurerm_resource_group.vm_group.name
  location            = azurerm_resource_group.vm_group.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  license_type        = "Windows_Server"
  network_interface_ids = [
    element(azurerm_network_interface.vm_network_interface.*.id, count.index),
  ]

  availability_set_id = azurerm_availability_set.vm_availability_set.id

  os_disk {
    caching              = "ReadOnly"
    storage_account_type = var.vm_disk_type
    disk_size_gb         = var.vm_disk_size
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.vm_sku
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  tags = {
    environment = var.vm_environment
  }

}
