
resource "aws_subnet" "Pub_subnet" {
  count                   = 2
  cidr_block              = var.Public_subnetConfigs[count.index].cidr_block
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  vpc_id = var.vpc_id
  tags = {
    Name = "pub-sub-${element(["us-east-1a", "us-east-1b"], count.index)}"
  }
}
resource "aws_subnet" "Prvt_subnet" {
  count                   = 2
  vpc_id                  = var.vpc_id
  cidr_block              = var.Prvt_SubnetConfigs[count.index].cidr_block
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "prvt-sub-${element(["us-east-1a", "us-east-1b"], count.index)}"
  }
}

resource "aws_subnet" "Db_subnet" {
  count = var.sub_count
  vpc_id = var.vpc_id
  cidr_block = var.db_subnetconfig[count.index].cidr_block
  availability_zone = element(var.availability_zones,count.index)

  tags = {
    "Name" = "Db_subnet-${element(var.availability_zones,count.index)}"
  }
  
}

resource "aws_db_subnet_group" "DB_subnet_Group" {
  name = "auroradbsubnetgroup"
  subnet_ids = [ aws_subnet.Db_subnet[0].id,aws_subnet.Db_subnet[1].id ]
   
}

output "public_subnet" {
  value = aws_subnet.Pub_subnet[*].id
}

output "Prvt_subnet" {
  value = aws_subnet.Prvt_subnet[*].id 
}
output "db_subnet" {
  value = aws_subnet.Db_subnet[*].id
  
}
output "vpc_id" {
    value = var.vpc_id
}
output "db_subnetGroup" {
  value = aws_db_subnet_group.DB_subnet_Group.id
  
}