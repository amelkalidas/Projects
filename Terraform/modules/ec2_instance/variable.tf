variable "ec2_ami" {  
}
variable "instance_type" {
  default = "t2.micro"
  
}
variable "ec2_keypair" {
  default = "LenovoKP"
  
}
variable "Public_Subnet" {
  description = "the subnet Id of the ec2 Instance" 
  
}
variable "PublicSG" {
  description = "securityGroup for the ec2 instnace."
}

variable "private_subnet" {}
variable "privateSG" {}
variable "instance_profile" {
  
}

