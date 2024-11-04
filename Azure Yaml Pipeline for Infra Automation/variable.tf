/*
variable "tfbackendstorage" {}
variable "tfcontainername" {}
variable "tfstorageRg" {}
variable "tfbackendfile" {}
*/


variable "env" {
    default = "prod"  
}
variable "depart" {
    default = "CoreInfra"
  
}

variable "prod-rg" {}
variable "location" {}
variable "prod-vnet-name" {}
variable "prod-vnet-address" {
    type = list(string)
    default = [ "10.10.0.0/16" ]
  
}
variable "public-subnet-name" {}
variable "public-subnet-address" {
    default = ["10.10.1.0/24"]  
}
variable "prod-public-nsg" {}
variable "public-sg-ports" {
    type = list(string)
    default = [ "22" , "80" , "3369" ]
}
