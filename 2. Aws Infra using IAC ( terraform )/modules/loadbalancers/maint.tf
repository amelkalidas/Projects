resource "aws_lb_target_group" "privt_app" {
  name = var.privatetgname
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id


  health_check {
    enabled = true
    interval = 30
    path = "/"
    protocol = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 3
  }  
}
resource "aws_lb" "internal_lb" {
  name               = var.internallbname
  internal           = true
  load_balancer_type = var.loadbalancer_type
  security_groups    = [var.internal_lb_sg]
  subnets            = var.private_subnet_lb[*]
  tags = {
    Environment = "Internal"
  }
}
resource "aws_lb_target_group_attachment" "prvt_app_attach" {
  target_group_arn = aws_lb_target_group.privt_app.arn
  target_id        = var.private_ec2
  port             = 80
  
}
resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.internal_lb.arn
  port              = "4000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.privt_app.arn
  }
}


resource "aws_lb_target_group" "public_tg" {
  name = var.public_tg_name
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id


  health_check {
    enabled = true
    interval = 30
    path = "/"
    protocol = "HTTP"
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb" "external_lb" {
  name               = var.external_Lb_name
  load_balancer_type = var.loadbalancer_type
  security_groups    = [var.external_lb_sg]
  subnets            = var.public_subnet_lb
  tags = {
    Environment = "External"
  }
}
resource "aws_lb_target_group_attachment" "public_app_attach" {
  target_group_arn = aws_lb_target_group.public_tg.arn
  target_id        = var.public_ec2
  port             = 80

}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.external_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_tg.arn
  }
}

output "public_tg" {
    value = aws_lb_target_group.public_tg.id
  
}
output "private_tg" {
    value = aws_lb_target_group.privt_app.id
  
}

output "public_lb_DNS" {
    value = aws_lb.external_lb.dns_name
  
}
output "private_lb_DNS" {
    value = aws_lb.internal_lb.dns_name
  
}

output "public_lb_sg" {
  value = aws_lb.external_lb.security_groups
  
}
output "prvt_lb_sg" {
  value = aws_lb.internal_lb.security_groups
  
}