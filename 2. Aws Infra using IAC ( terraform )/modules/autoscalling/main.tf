resource "aws_launch_template" "Public_launch_template_ASG" {
    name = "lt-for-publicasg"
    instance_type = var.instance_type
    vpc_security_group_ids = [var.public_launchTemplate_SecurityGroup]
    key_name = var.launch_template_keypair
    iam_instance_profile {
      name =  var.instance_profile_name
    }
    image_id = var.image_id
    tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "Public_Instance"
      launch_template = "Public_launch_template_ASG"
      # Add more tags as needed
      }
    }
} 

resource "aws_launch_template" "Private_launch_template_ASG" {
    name = "lt-for-private-asg"
    instance_type = var.instance_type
    vpc_security_group_ids = [var.Private_launchTemplate_SecurityGroup]
    image_id = var.image_id
    key_name = var.launch_template_keypair
    tag_specifications {
      resource_type = "instance"
      tags = {
      Name        = "private_instance"
      launch_template = "Private_launch_template_ASG"
      # Add more tags as needed
      }
    
    }
}

resource "aws_autoscaling_group" "public_asg" {
    name = var.public_asg_name
    max_size = "1"
    min_size = "1"
    health_check_grace_period = "300"
    desired_capacity = "1"
    health_check_type = "ELB"
    force_delete = true
    target_group_arns = [ var.public_tg_arn ]
    launch_template {
      id = aws_launch_template.Public_launch_template_ASG.id
      version = "$Latest"
    }

    vpc_zone_identifier = var.public_subnet

    instance_maintenance_policy {
      min_healthy_percentage = 90
      max_healthy_percentage = 120
    }
    tag {
    key                 = "Type"
    value               = "External"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_group" "private_asg" {
    name = var.prvt_asg_name
    max_size = "1"
    min_size = "1"
    health_check_grace_period = "300"
    desired_capacity = "1"
    health_check_type = "ELB"
    force_delete = true
    target_group_arns = [var.private_tg_arn] 
    launch_template {
      id = aws_launch_template.Private_launch_template_ASG.id
      version = "$Latest"
    }

    vpc_zone_identifier = var.private_subnet[*]

    instance_maintenance_policy {
      min_healthy_percentage = 90
      max_healthy_percentage = 120
    }
    tag {
    key                 = "Type"
    value               = "internal"
    propagate_at_launch = true
  }

}