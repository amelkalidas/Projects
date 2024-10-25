variable "Location" {
    default = "centralindia"  
}
variable "prod_rg_name" {
    default = "prod-rg"
  
}
variable "test_rg_name" {
    default = "test-rg"
  
}
variable "common_tags" {
    type = map(string)
    default = {
      owner = "amel"
      org = "devops"
    }
  
}



