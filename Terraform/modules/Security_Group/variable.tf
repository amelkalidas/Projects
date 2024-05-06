variable "ports" {
  type    = list(number)
  default = [22, 80, 443]

}
variable "tags" {
  description = "tags for the securityGroup"

}
variable "vpc_id" {
  description = "vpc Id details"

}
variable "from_port" {}
variable "to_port" {}
variable "protocol" {}
variable "myIp" {}