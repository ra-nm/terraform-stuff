output "vm_ip"
{
  value = "${azurerm_public_ip.myip.ip_address}"
}
