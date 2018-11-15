module mycompute {
  source="Azure/compute/azurerm"
  resource_group_name="${var.rg}"
  location="${var.location}"
  admin_password="Northwest1234!"
  admin_username="azureops"
  vm_os_simple="WindowsServer"
  remote_port="3389"
  nb_instances=2
  public_ip_dns=["${var.rg}"]
  vnet_subnet_id="${module.network.vnet_subnets[0]}"
}

module "network" {
  source="Azure/network/azurerm"
  resource_group_name="${var.rg}"
  location="${var.location}"
}

output "vm_public_name" {
  value="${module.mycompute.public_ip_dns_name}"
}

output "vm_public_ip" {
  value="${module.mycompute.public_ip_address}"
}

output "vm_private_ips" {
  value="${module.mycompute.network_interface_private_ip}"
}
