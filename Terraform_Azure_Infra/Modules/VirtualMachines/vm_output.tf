output "pub_vm_name" {
    value = azurerm_linux_virtual_machine.prod_public_Vm.name
  
}
output "pub_vm_Id" {
    value = azurerm_linux_virtual_machine.prod_public_Vm.id
  
}
output "db_vm_name" {
    value = azurerm_linux_virtual_machine.prod_Private_Vm.name
  
}
output "db_vm_id" {
    value = azurerm_linux_virtual_machine.prod_Private_Vm.id
  
}