resource "azurerm_recovery_services_vault" "recovery_vault" {
  name = var.recoveryvaultname
  location = var.Location
  resource_group_name = var.prod_rg_name
  sku = "Standard"
  immutability = "Disabled"
  storage_mode_type = "LocallyRedundant"
  soft_delete_enabled = false
}

resource "azurerm_backup_policy_vm" "vm_backup_policy" {
  name = "Infrastrucure-server-backup-policy"
  resource_group_name = var.prod_rg_name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_vault.name
  
  timezone = "UTC"

  backup {
    frequency = "Daily"
    time = "22:00"
  }
  
  retention_daily {
    count = "7"
  }

}

resource "azurerm_backup_protected_vm" "host0-backup" {
  recovery_vault_name = azurerm_recovery_services_vault.recovery_vault.name
  resource_group_name = var.prod_rg_name
  source_vm_id = var.pub_vm_Id
  backup_policy_id = azurerm_backup_policy_vm.vm_backup_policy.id  
  depends_on = [ azurerm_recovery_services_vault.recovery_vault ]
}
resource "azurerm_backup_protected_vm" "database-backup" {
  recovery_vault_name = azurerm_recovery_services_vault.recovery_vault.name
  resource_group_name = var.prod_rg_name
  source_vm_id = var.db_vm_id
  backup_policy_id = azurerm_backup_policy_vm.vm_backup_policy.id  
  depends_on = [ azurerm_recovery_services_vault.recovery_vault ]
}