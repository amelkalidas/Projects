variable "subscriptionId" {             # During Terraform plan we can input the subscription.
    type = string
    default = ""
}
variable "Location" {
    default = "centralindia"  
}
variable "storageaccount" {
  default = "opsprodfileshare01"
  type = string
  description = "file share for the ops ."
  
}
variable "recoveryvaultname" {
  default = "CentralIndia-RV"
  
}
variable "common_tags" {
  type = map(string)
  default = {
    owner = "Amel"
    ORG = "devOps"
  }
  
}
variable "prod_rg_name" {
  default = "OPS_PROD_RG"
  
}
variable "test_rg_name" {
  default = "OPS_test_RG"
  
}
variable "publi_sg_name" {
  default = "OPS_Public_SG"
  
}
variable "public_sg_name" {
  default = "OPS_Public_SG"
  
}
variable "private_sg_name" {
  default = "ops_private_sg"
  
}
variable "prod_vnet_name" {
  default = "OPS_PROD_VNET"
  
}
variable "prod_vnet_address-prefix" {
  type = list(string)
  default = ["10.0.0.0/16"]
}
variable "public_subnet_name" {
  default = "Ops_Public_subnet01"
  
}
variable "private_subnet_name" {
  default = "ops_private_subnet01"
  
}
variable "pub_vm_name" {
  default = "Host-0"
  
}
variable "pub_vm_size" {
  default = "Standard_B1s"
  
}
variable "vm_admin_username" {
  default = "adminuser"
  
}
variable "vm_image_sku" {
  default = "22_04-lts"
  
}
variable "db_vm_name" {
  default = "prod-db-01"
  
}
variable "db_vm_size" {
  default = "Standard_B1s"
  
}
variable "storage_account_type" {
  default = "Standard"
  
}
variable "storage_replication_type" {
  default = "LRS"
  
}
variable "storage_fileshare_name" {
  default = "prodshare"
  
}
variable "storage_fileshare_quota" {
  default = 50
  
}