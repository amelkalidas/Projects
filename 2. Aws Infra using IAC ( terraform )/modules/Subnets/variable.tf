variable "vpc_id" {
  description = "VPC ID"

}

variable "sub_count" {
  default = 2
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1b", "ap-south-1a"]
}

variable "Public_subnetConfigs" {
  type = list(object({
    name_prefix = string
    cidr_block  = string
  }))
  default = [
    {
      name_prefix = "subnet-1"
      cidr_block  = "10.10.1.0/24"
    },
    {
      name_prefix = "subnet-2"
      cidr_block  = "10.10.2.0/24"
    }
  ]
}

variable "Prvt_SubnetConfigs" {
  type = list(object({
    name_prefix = string
    cidr_block  = string
  }))
  default = [
    {
      name_prefix = "subnet-3"
      cidr_block  = "10.10.3.0/24"
    },
    {
      name_prefix = "subnet-4"
      cidr_block  = "10.10.4.0/24"
    }
  ]
}

variable "db_subnetconfig" {
  type = list(object({
    name_prefix = string
    cidr_block  = string
  }))
  default = [
    {
      name_prefix = "db_subnet01"
      cidr_block  = "10.10.5.0/24"

    },
    {
      name_prefix = "db_subnet02"
      cidr_block  = "10.10.6.0/24"
    }
  ]

}