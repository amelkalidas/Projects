resource "azurerm_linux_virtual_machine" "prod_public_Vm" {
  name                = var.pub_vm_name
  resource_group_name = var.prod_rg_name
  location            = var.Location
  size                = var.pub_vm_size
  admin_username      = var.vm_admin_username
  admin_ssh_key {
    username = "adminuser"
    public_key = file("C:\\Users\\Lenovo\\.ssh\\id_rsa.pub") 
  }
  network_interface_ids = [
    var.public_vm_nic_id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.vm_image_sku
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "prod_Private_Vm" {
  name                = var.db_vm_name
  resource_group_name = var.prod_rg_name
  location            = var.Location
  size                = var.db_vm_size
  admin_username      = var.vm_admin_username
  admin_ssh_key {
    username = "adminuser"
    public_key = file("C:\\Users\\Lenovo\\.ssh\\id_rsa.pub") 
  }
  network_interface_ids = [
    var.db_vm_nic_id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.vm_image_sku
    version   = "latest"
  }
}