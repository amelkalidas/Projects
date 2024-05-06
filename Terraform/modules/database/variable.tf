variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1b", "ap-south-1a"]
}
variable "db_subnet_group_config" {}
variable "db_security_group" {}
variable "db_name" {}
variable "db_password" {}