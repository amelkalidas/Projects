resource "azurerm_resource_group" "prod_rg" {
  name     = var.prod_rg_name
  location = var.Location
}

resource "azurerm_resource_group" "Test_RG01" {
  name     = var.test_rg_name
  location = var.Location
  tags = var.common_tags
}