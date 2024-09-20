terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}                                 
//  subscription_id = """
//  tenant_id = "
//  client_id = "mention client ID"
//  client_secret = "mention client secret"
}

