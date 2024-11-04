resource "azurerm_storage_account" "prod_storage" {
  name = var.storageaccount
  resource_group_name = var.prod_rg_name
  location = var.Location
  account_tier = var.storage_account_type
  account_replication_type = var.storage_replication_type
  tags = {
    environment = "DevOps"

  }  
}
resource "azurerm_storage_account_network_rules" "prod_storage_networkrule" {
  storage_account_id = azurerm_storage_account.prod_storage.id

  default_action             = "Allow"
  virtual_network_subnet_ids = [var.prod_public_subnet_id , var.prod_private_subnet_id]
  bypass                     = ["Metrics","AzureServices"]
}

resource "azurerm_storage_share" "prod_share" {
  name                 = var.storage_fileshare_name
  storage_account_name = azurerm_storage_account.prod_storage.name
  quota                = var.storage_fileshare_quota
}