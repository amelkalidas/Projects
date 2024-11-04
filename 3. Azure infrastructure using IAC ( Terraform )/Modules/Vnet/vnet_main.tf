resource "azurerm_virtual_network" "Prod_vnet" {
  name                = var.prod_vnet_name
  location            = var.Location
  resource_group_name = var.prod_rg_name
  address_space       = var.prod_vnet_address-prefix
  tags = {
    environment = "DevOps"
  }
}

resource "azurerm_subnet" "public_subnet01" {
  name                 = var.public_subnet_name
  resource_group_name  = var.prod_rg_name
  virtual_network_name = azurerm_virtual_network.Prod_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints = [ "Microsoft.Storage" ]                               # this enables service endpoint for the storage accoutn to connect securely.

}

resource "azurerm_subnet" "private_subnet01" {
  name                 = var.private_subnet_name
  resource_group_name  = var.prod_rg_name
  virtual_network_name = azurerm_virtual_network.Prod_vnet.name
  default_outbound_access_enabled = false                                   # this makes the subnet Private.
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints = [ "Microsoft.Storage" ]                               # this enables service endpoint for the storage accoutn to connect securely.

}

# NIC Configuration 

resource "azurerm_network_interface" "PublicVM_NIC" {

  name                = "HOST01-nic"
  location            = var.Location
  resource_group_name = var.prod_rg_name

  ip_configuration {
    name                          = "public_bound"
    subnet_id                     = azurerm_subnet.public_subnet01.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [ azurerm_subnet.public_subnet01 ]
}
  
resource "azurerm_network_interface" "prvt_db_nic" {
  name = "db_nic"
  location = var.Location
  resource_group_name = var.prod_rg_name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.private_subnet01.id
    private_ip_address_allocation = "Dynamic"

  }
  
  depends_on = [ azurerm_subnet.private_subnet01 ]
}
resource "azurerm_network_security_group" "public_sg" {
  name                = var.publi_sg_name
  location            = var.Location
  resource_group_name = var.prod_rg_name
}

resource "azurerm_network_security_group" "private_sg" {
  name = var.private_sg_name
  location = var.Location
  resource_group_name = var.prod_rg_name
  
}