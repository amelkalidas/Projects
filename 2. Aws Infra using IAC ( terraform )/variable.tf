variable "aws_region" {
  default = "ap-south-1"
}
variable "vpc_cidr" {
  default = "10.10.0.0/16"
}
variable "vpc_name" {
  default = "Prod_vpc"
}

variable "ec2_ami" {
  default = "ami-024c2108cab7f99b7"  #ApacheImageV2

}
variable "instance_type" {
  default = "t2.micro"

}
variable "ec2_keypair" {
  default = "LenovoKP"

}
variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1b", "ap-south-1a"]
}
