variable "subscriptionId" {             # During Terraform plan we can input the subscription.
    type = string
    default = "8d3ed687-4dc7-4a9b-903a-b9a14bde85c4"
}

variable "Location" {
    default = "centralindia"  
}

variable "admin_password" {
  description = "The admin password for the Linux VM"
  type        = string  
}

variable "storageaccount" {
  default = "opsprodfileshare01"
  type = string
  description = "file share for the ops ."
  
}

variable "recoveryvaultname" {
  default = "CentralIndia-RV"
  
}