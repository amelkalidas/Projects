resource "azurerm_resource_group" "prod-rg" {
    name = "${var.prod-rg}-${var.depart}"
    location = var.location
}

resource "azurerm_virtual_network" "prod-vnet" {
    name = "${var.prod-vnet-name}-${var.depart}"
    resource_group_name = azurerm_resource_group.prod-rg.name
    location = azurerm_resource_group.prod-rg.location
    address_space = var.prod-vnet-address  
}

resource "azurerm_subnet" "prod-public-subnet" {
    name = "${var.public-subnet-name}-${var.depart}"
    resource_group_name = azurerm_resource_group.prod-rg.name
    virtual_network_name = azurerm_virtual_network.prod-vnet.name
    address_prefixes = var.public-subnet-address
}
resource "azurerm_network_security_group" "prod-nsg" {
    name = "${var.prod-public-nsg}-${var.depart}"
    location = azurerm_resource_group.prod-rg.location
    resource_group_name = azurerm_resource_group.prod-rg.name
    dynamic "security_rule" {
        for_each = var.public-sg-ports
        content {
          name = "allow-${security_rule.value}"
          priority = 100 + index(var.public-sg-ports , security_rule.value) * 20
          direction = "Inbound"
          access = "Allow"
          protocol = "Tcp"
          source_port_range = "*"
          source_address_prefix = "*"
          destination_port_range = "*"
          destination_address_prefix = "*"
        }
      
    }

      
}
resource "azurerm_public_ip" "pip" {
    name = "winserver-public-pip"
    resource_group_name = azurerm_resource_group.prod-rg.name
    location = azurerm_resource_group.prod-rg.location
    allocation_method = "Static"

  
}
resource "azurerm_network_interface" "win-server-nic" {
    name = "win-vm-nic"
    resource_group_name = azurerm_resource_group.prod-rg.name
    location = azurerm_resource_group.prod-rg.location
    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.prod-public-subnet.id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.pip.id
    }
  
}


