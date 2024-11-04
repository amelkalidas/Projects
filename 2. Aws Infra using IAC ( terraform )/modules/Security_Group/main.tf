resource "aws_security_group" "public_instnace_SG" {
  name        = "Public_Instance_SG"
  vpc_id      = var.vpc_id
  description = "security groups for Instance in Public subnets in any az"
  revoke_rules_on_delete = true
  tags = {
    vpcId = var.tags

  }

  dynamic "ingress" {
    iterator = port
    for_each = var.ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "private_instnace_SG" {
  depends_on = [ aws_security_group.internal_alb_sg ]
  name        = "Private_instance_SG"
  vpc_id      = var.vpc_id
  description = "security groups for Instance in Private subnets in any az"
  revoke_rules_on_delete = true

  tags = {
    vpcId = var.tags

  }

  ingress {

    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = var.myIp
  }
  ingress {

    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    security_groups = [aws_security_group.internal_alb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "internal_alb_sg" {
  name        = "internal_alb_sg"
  vpc_id      = var.vpc_id
  description = "security groups for Instance in Internal Loadbalancer in any az"
  revoke_rules_on_delete = true

  tags = {
    vpcId = var.tags

  }

  ingress {

    from_port   = "80"
    to_port     = "80"
    protocol    = var.protocol
    security_groups =  [aws_security_group.public_instnace_SG.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
}
resource "aws_security_group" "external_alb_sg" {
  name        = "external_alb_sg"
  vpc_id      = var.vpc_id
  description = "security groups for Instance in External Loadbalancer in any az"
  revoke_rules_on_delete = true
  tags = {
    vpcId = var.tags

  }

  ingress {

    from_port   = "80"
    to_port     = "80"
    protocol    = var.protocol
    cidr_blocks =  var.myIp
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "DB SG"
  vpc_id      = var.vpc_id
  revoke_rules_on_delete = true

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_instnace_SG.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


data "http" "myIp" {
  url = "http://ipv4.icanhazip.com"
  
}
output "db_security_group" {
  value = aws_security_group.db_sg.id
  
}


output "public_sg_id" {
  value = aws_security_group.public_instnace_SG.id
}
output "private_sg_id" {
  value = aws_security_group.private_instnace_SG.id
}
output "external_alb_sg" {
  value = aws_security_group.external_alb_sg.id
  
}
output "internal_alb_sg" {
  value = aws_security_group.internal_alb_sg.id
  
}

