resource "aws_vpc" "mumbai_VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Region = "Mumbai"
    Env    = "PROD"
    Name   = var.vpc_name
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.mumbai_VPC.id
  tags = {
    Region = "Mumbai"
    Env    = "PROD"
    Name   = var.vpc_name
  }  
}
resource "aws_eip" "Nat1" {
  tags = {
    Name = "eip1"
  }
}
resource "aws_eip" "Nat2" {
  tags = {
    Name = "eip2"
  }
}
resource "aws_nat_gateway" "NGW1" {
  subnet_id =  var.ngw_public_subnet
  allocation_id = aws_eip.Nat1.id
  
}
resource "aws_nat_gateway" "NGW2" {
  subnet_id =  var.ngw_public_subnet_2
  allocation_id = aws_eip.Nat2.id  
}

resource "aws_route_table" "PublicSubnet_routeTable" {
  vpc_id = aws_vpc.mumbai_VPC.id
  tags = {
    Name = "Public_Route_table"
  }
  
}
resource "aws_route_table" "Private_subnet_RT_1" {
  vpc_id = aws_vpc.mumbai_VPC.id
  tags = {
    Name = "Private_route_table_1"
  }
  
}
resource "aws_route_table" "Private_subnet_RT_2" {
  vpc_id = aws_vpc.mumbai_VPC.id
  tags = {
    Name = "Private_route_table_2"
  }
  
}
resource "aws_route" "Public_route" {
  route_table_id = aws_route_table.PublicSubnet_routeTable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IGW.id
}
resource "aws_route" "private_route_1" {
  route_table_id = aws_route_table.Private_subnet_RT_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NGW1.id
}
resource "aws_route" "private_route_2" {
  route_table_id = aws_route_table.Private_subnet_RT_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NGW2.id
}

resource "aws_route_table_association" "Public_route_association" {
  subnet_id = var.ngw_public_subnet
  route_table_id = aws_route_table.PublicSubnet_routeTable.id
}

resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id = var.ngw_prvt_subnet_1
  route_table_id = aws_route_table.Private_subnet_RT_1.id  
}
resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id = var.ngw_prvt_subnet_2
  route_table_id = aws_route_table.Private_subnet_RT_2.id 
}

output "ngw1" {
  value = aws_nat_gateway.NGW1.public_ip
  
}
output "ngw2" {
  value = aws_nat_gateway.NGW2.public_ip 
}

output "vpc_id" {
    value = aws_vpc.mumbai_VPC.id
  
}
output "vpc_cidr" {
  value = aws_vpc.mumbai_VPC.cidr_block
  
}
output "ngw1Id" {
  value = aws_nat_gateway.NGW1.id
  
}
output "ngw2id" {
  value = aws_nat_gateway.NGW2.id
  
}

