
output "public_lb_DNS" {
  value = module.loadbalancers.public_lb_DNS
}
output "private_lb_DNS" {
  value = module.loadbalancers.private_lb_DNS
  
}
output "s3_bucket_arn" {
  value = module.s3_bucket.s3_bucket_arn
}
output "aws_rds_cluster_arn" {
  value = module.database.aws_rds_cluster_arn
}
output "aws_rds_cluster_endpoint" {
  value = module.database.aws_rds_cluster_endpoint 
}
output "aws_rds_instance_identifier" {
  value = module.database.aws_rds_instance_identifier[*]
}
output "subnet_id" {
  value = module.subnets.public_subnet[*] 
}
output "public_sg_id" {
  value = module.securityGroup.public_sg_id
  
}
output "private_sg_id" {
  value = module.securityGroup.private_sg_id
  
}
output "Pub_ec2_Instance_id" {
  value = module.ec2_instance.Pub_ec2_Instance_id
  
}
output "Prvt_ec2_Instance_id" {
  value = module.ec2_instance.Private_ec2
}
output "ngw1" {
  value = module.networking.ngw1  
}
output "ngw2" {
  value = module.networking.ngw2
}
output "public_lb_sg" {
    value = module.loadbalancers.public_lb_sg
  
}
output "private_lb_sg" {
    value = module.loadbalancers.prvt_lb_sg
  
}
output "ec2_instance_profile_attached" {
    value = module.ec2_instance.ec2_instance_profile_attached
  
}

output "public_ec2_name" {
    value = module.ec2_instance.public_ec2_name
  
}

output "private_ec2_name" {
    value = module.ec2_instance.private_ec2_name
  
}