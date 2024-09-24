variable "subscriptionId" {             # During Terraform plan we can input the subscription.
    type = string
    default = ""
}

variable "Location" {
    default = "centralindia"  
}

variable "storageaccount" {
  default = "opsprodfileshare01"
  type = string
  description = "file share for the ops ."
  
}

variable "recoveryvaultname" {
  default = "CentralIndia-RV"
  
}