variable "vpc_cidr" {
  default = "10.10.0.0/16"
}
variable "vpc_name" {
  default = "Prod_vpc"
}

variable "ngw_public_subnet" {}
variable "ngw_public_subnet_2" {}
variable "ngw_prvt_subnet_1" {}
variable "ngw_prvt_subnet_2" {}
