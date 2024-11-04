# Resource Group configuration

module "resource_group" {
  source       = "./Modules/ResourceGroup"
  Location     = var.Location
  prod_rg_name = var.prod_rg_name
  test_rg_name = var.test_rg_name
}

module "vnet_configuration" {
  source                   = "./Modules/Vnet"
  prod_vnet_name           = var.prod_vnet_name
  prod_vnet_address-prefix = var.prod_vnet_address-prefix
  Location                 = module.resource_group.rg_location
  prod_rg_name             = module.resource_group.prod_rg_name
  publi_sg_name            = var.public_sg_name
  private_sg_name          = var.private_sg_name
  public_subnet_name       = var.public_subnet_name
  private_subnet_name      = var.private_subnet_name
}

module "Vm" {
  source              = "./Modules/VirtualMachines"
  Location            = module.resource_group.rg_location
  prod_rg_name        = module.resource_group.prod_rg_name
  public_sg_name      = var.public_sg_name
  private_sg_name     = var.private_sg_name
  public_subnet_name  = module.vnet_configuration.prod_public_subnet_name
  private_subnet_name = module.vnet_configuration.prod_private_subnet_name
  pub_vm_name         = var.pub_vm_name
  pub_vm_size         = var.pub_vm_size
  vm_admin_username   = var.vm_admin_username
  vm_image_sku        = var.vm_image_sku
  db_vm_name          = var.db_vm_name
  db_vm_size          = var.db_vm_size
  public_vm_nic_id    = module.vnet_configuration.public_vm_nic_id
  db_vm_nic_id        = module.vnet_configuration.db_vm_nic_id
}

module "storageaccout_staticwebsite" {
  source                   = "./Modules/Storageaccount"
  storageaccount           = var.storageaccount
  prod_rg_name             = module.resource_group.prod_rg_name
  Location                 = module.resource_group.rg_location
  storage_account_type     = var.storage_account_type
  storage_replication_type = var.storage_replication_type
  prod_public_subnet_id    = module.vnet_configuration.prod_public_subnet_id
  prod_private_subnet_id   = module.vnet_configuration.prod_private_subnet_id
  storage_fileshare_name   = var.storage_fileshare_name
  storage_fileshare_quota  = var.storage_fileshare_quota

}

module "recovery_vault_backup" {
  source            = "./Modules/Backup policies"
  recoveryvaultname = var.recoveryvaultname
  prod_rg_name      = module.resource_group.prod_rg_name
  Location          = module.resource_group.rg_location
  pub_vm_Id         = module.Vm.pub_vm_Id
  db_vm_id          = module.Vm.db_vm_id
}