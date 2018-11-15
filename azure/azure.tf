/*
provider "azurerm" {
  subscription_id = "${var.sub_id}" 
  client_id = "${var.appid}"
  client_secret = "${var.password}"
  tenant_id = "${var.tenant}"
}
*/

resource "azurerm_resource_group" "thegroup"
{
  name="${var.rg}"
  location="${var.location}"
}

output "stuff" {
  value="${azurerm_resource_group.thegroup.name}"
}
