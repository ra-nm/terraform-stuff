variable "yo"
{
  type="string"
  default="qewqwe"
  description="Yo Val:"
}
variable "appid" {}
variable "password" {}
variable "sub_id" {}
variable "tenant" {}
variable "rg" {}
variable "location" {}
output "more" {
  value="${var.appid}"
}

