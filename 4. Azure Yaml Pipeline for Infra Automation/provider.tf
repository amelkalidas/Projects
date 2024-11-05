terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 4.0.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "tfstatefile29"
    container_name = "test"
    key = "test.tfstate"
    resource_group_name = "29102024"        
  }
}

provider "azurerm" {
    features {}  
}