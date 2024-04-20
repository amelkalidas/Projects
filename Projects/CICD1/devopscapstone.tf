provider "aws" {
  region = "us-east-1"
  
}
# Create a VPC
resource "aws_vpc" "CapstonePJ1" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "capstonepj1"
  }
}
resource "aws_subnet" "Pubsubnet1" {
    vpc_id = aws_vpc.CapstonePJ1.id
    cidr_block = "10.10.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true


    tags = {
        Name = "PublicSubnet01"
    }
}
resource "aws_subnet" "Prvsubnet2" {
    vpc_id = aws_vpc.CapstonePJ1.id
    cidr_block = "10.10.1.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "PrivateSubnet01"
    }
}
resource "aws_security_group" "public_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.CapstonePJ1.id
  

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
   ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.CapstonePJ1.cidr_block]    
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     
  }
  ingress {
    description      = "For Jenkin Console communication"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls_to_publicSub"
  }
}
# Create security group for private subnet
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.CapstonePJ1.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming traffic from the public subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    security_groups = [aws_security_group.public_sg.id]
  }
  
  tags = {
    Name = "private-security-group"
  }
}
resource "aws_internet_gateway" "CapstonePJ1GW" {
  vpc_id = aws_vpc.CapstonePJ1.id

  tags = {
    Name = "CapstonePJ1GW"
  }
}
resource "aws_route_table" "capstonepj1Routetable" {
  vpc_id = aws_vpc.CapstonePJ1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.CapstonePJ1GW.id
  }

  tags = {
    Name = "IGW"
  }
}
resource "aws_main_route_table_association" "CapstonMainRouteTable" {
    vpc_id = aws_vpc.CapstonePJ1.id
    route_table_id = aws_route_table.capstonepj1Routetable.id 
}

resource "aws_instance" "MasterInstance" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id = aws_subnet.Pubsubnet1.id
  associate_public_ip_address = true
  key_name = "capstonekeypair"

  tags = {
    Name = "MasterInstance"
  }
}
resource "aws_instance" "Agent1" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id = aws_subnet.Pubsubnet1.id
  associate_public_ip_address = true
  
  key_name = "capstonekeypair"

  tags = {
    Name = "Agent1"
  }
}
resource "aws_instance" "Agent2" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id = aws_subnet.Pubsubnet1.id
  associate_public_ip_address = true

  key_name = "capstonekeypair"

  tags = {
    Name = "Agent2"
  }
}

output "masterec2_ip" {
  value = aws_instance.MasterInstance.public_ip
  description = "The public ip of the MasterInstance"
}
