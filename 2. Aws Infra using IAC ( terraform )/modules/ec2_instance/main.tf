resource "aws_instance" "Pub_ec2" {
  subnet_id     = var.Public_Subnet
  ami           = var.ec2_ami
  instance_type = var.instance_type
  key_name      = var.ec2_keypair
  vpc_security_group_ids = [var.PublicSG]
  iam_instance_profile = var.instance_profile
  tags = {
    Name = "Initial Public Ec2"
  }
}

resource "aws_instance" "private_ec2" {
  subnet_id     = var.private_subnet
  ami           = var.ec2_ami
  instance_type = var.instance_type
  key_name      = var.ec2_keypair
  vpc_security_group_ids = [var.privateSG] 
  tags = {
    Name = "Initial Private Ec2"
  }
}

output "ec2_subnetId" {
  value = aws_instance.Pub_ec2.subnet_id
}
output "sg_id" {
  value = aws_instance.Pub_ec2.vpc_security_group_ids 
}
output "Pub_ec2_Instance_id" {
  value = aws_instance.Pub_ec2.id
}
output "Private_ec2" {
  value = aws_instance.private_ec2.id
}

output "ec2_instance_profile_attached" {
  value = aws_instance.Pub_ec2.iam_instance_profile
  
}
output "public_ec2_name" {
  value = aws_instance.Pub_ec2.tags
}
output "private_ec2_name" {
  value = aws_instance.private_ec2.tags
  
}