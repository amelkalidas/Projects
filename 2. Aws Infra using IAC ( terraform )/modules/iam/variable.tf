variable "aws_iam_policy_s3" {
    default = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  
}
variable "aws_iam_policy_ssm" {
    default = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  
}
variable "ec2profile_name" {}