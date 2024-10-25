variable "Location" {}
variable "prod_rg_name" {}
variable "publi_sg_name" {}
variable "private_sg_name" {}
variable "prod_vnet_name" {}
variable "prod_vnet_address-prefix" {
  type = list(string)
}
variable "public_subnet_name" {}
variable "private_subnet_name" {}
