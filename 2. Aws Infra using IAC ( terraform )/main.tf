module "networking" {
  source = "./modules/networking"
  ngw_public_subnet = module.subnets.public_subnet[0]
  ngw_public_subnet_2 = module.subnets.public_subnet[1]
  ngw_prvt_subnet_1 = module.subnets.Prvt_subnet[0]
  ngw_prvt_subnet_2 = module.subnets.Prvt_subnet[1]
} 
module "securityGroup" {
  source = "./modules/Security_Group"
  tags   = module.networking.vpc_id
  vpc_id = module.networking.vpc_id
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  myIp = ["${chomp(data.http.ipinfo.response_body)}/32"]
}
module "subnets" {
  source = "./modules/Subnets"
  vpc_id = module.networking.vpc_id
  sub_count  = 2
}
# Will create 2 ec2 instance 
module "ec2_instance" {
  source = "./modules/ec2_instance"
  Public_Subnet = module.subnets.public_subnet[0]
  PublicSG = module.securityGroup.public_sg_id 
  private_subnet = module.subnets.Prvt_subnet[1]
  privateSG = module.securityGroup.private_sg_id
  instance_profile = module.iam.instance_profile_name
  ec2_ami = var.ec2_ami
  
}

module "database" {
  source = "./modules/database"
  db_security_group = module.securityGroup.db_security_group
  db_subnet_group_config = module.subnets.db_subnetGroup
  db_name = "admin"
  db_password = "adminpassword1234"
  availability_zones = var.availability_zones
}

module "s3_bucket" {
  source = "./modules/s3bucket"
  s3_bucket = "goodbucketfortheday29tf"
  
}

module "loadbalancers" {
  source = "./modules/loadbalancers"
  vpc_id = module.networking.vpc_id
  privatetgname = "targetforprivatelb"
  public_tg_name = "targetforpubliclb"
  internallbname = "internallb"
  loadbalancer_type = "application"
  internal_lb_sg = module.securityGroup.internal_alb_sg
  private_subnet_lb = module.subnets.Prvt_subnet[*]
  private_ec2 = module.ec2_instance.Private_ec2
  external_Lb_name = "externallb"
  public_ec2 = module.ec2_instance.Pub_ec2_Instance_id
  public_subnet_lb = module.subnets.public_subnet[*]
  external_lb_sg = module.securityGroup.external_alb_sg
}

module "autoscalling" {
  source = "./modules/autoscalling" 
  instance_type = "t2.micro"
  image_id =  "ami-0166545f704b3be23"
  public_asg_name = "public-asg"
  public_tg_arn = module.loadbalancers.public_tg
  public_subnet = module.subnets.public_subnet[*]
  prvt_asg_name = "private-asg"
  private_tg_arn = module.loadbalancers.private_tg
  private_subnet = module.subnets.Prvt_subnet[*]
  instance_profile_name = module.iam.instance_profile_name
  public_launchTemplate_SecurityGroup = module.securityGroup.public_sg_id
  Private_launchTemplate_SecurityGroup = module.securityGroup.private_sg_id
  launch_template_keypair = var.ec2_keypair
}

module "iam" {
  source = "./modules/iam"
  ec2profile_name = module.iam.instance_profile_name
  aws_iam_policy_s3 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  aws_iam_policy_ssm = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}