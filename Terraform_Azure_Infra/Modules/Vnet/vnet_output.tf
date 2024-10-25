output "prod_vnet_name" {
    value = azurerm_virtual_network.Prod_vnet.name
  
}
output "prod_vnet_id" {
    value = azurerm_virtual_network.Prod_vnet.id
  
}
output "prod_public_subnet_id" {
    value = azurerm_subnet.public_subnet01.id
  
}
output "prod_private_subnet_id" {
    value = azurerm_subnet.private_subnet01.id
  
}
output "prod_public_subnet_name" {
    value = azurerm_subnet.public_subnet01.name
  
}
output "prod_private_subnet_name" {
    value = azurerm_subnet.private_subnet01.name
  
}
output "public_vm_nic_id" {
    value = azurerm_network_interface.PublicVM_NIC.id
  
}
output "db_vm_nic_id" {
    value = azurerm_network_interface.prvt_db_nic.id
  
}