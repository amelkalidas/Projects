resource "aws_rds_cluster" "WebDB" {
  cluster_identifier      = "aurora-db-1"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  availability_zones      = var.availability_zones
  database_name           = var.db_name
  master_username         = var.db_password
  master_password         = var.db_password
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  db_subnet_group_name    = var.db_subnet_group_config
  vpc_security_group_ids  = [var.db_security_group]
  lifecycle {
    ignore_changes = [engine, master_username, master_password, engine_version, database_name,availability_zones]
  }
  
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-db-1-${count.index}"
  cluster_identifier = aws_rds_cluster.WebDB.id
  instance_class     = "db.r5.xlarge"
  engine             = aws_rds_cluster.WebDB.engine
  engine_version     = aws_rds_cluster.WebDB.engine_version
  db_subnet_group_name = var.db_subnet_group_config
  lifecycle {
    ignore_changes =  [identifier, engine, engine_version, cluster_identifier]
  }
}


output "aws_rds_cluster_arn" {
    value = aws_rds_cluster.WebDB.arn
  
}
output "aws_rds_cluster_endpoint" {
    value = aws_rds_cluster.WebDB.endpoint
  
}
output "aws_rds_instance_identifier" {
  value = aws_rds_cluster_instance.cluster_instances[*].identifier
}
