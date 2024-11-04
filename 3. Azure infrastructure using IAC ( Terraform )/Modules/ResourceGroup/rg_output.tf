output "prod_rg_name" {
    value = azurerm_resource_group.prod_rg.name
  
}
output "test_rg_name" {
    value = azurerm_resource_group.Test_RG01.name
  
}
output "rg_location" {
    value = azurerm_resource_group.prod_rg.location
  
}