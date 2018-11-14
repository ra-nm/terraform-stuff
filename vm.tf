resource "azurerm_virtual_network" "mynet"
{
  name="table5ravnet"
  address_space=["10.0.0.0/16"]
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  tags {
    environment="Testing"
  }
}

resource "azurerm_subnet" "mysub"
{
  name="vm"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  virtual_network_name="${azurerm_virtual_network.mynet.name}"
  address_prefix="10.0.1.0/24"
}


resource "azurerm_public_ip" "myip"
{
  name="table5ratfvmip"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  public_ip_address_allocation="dynamic"
  tags{
    environment="testing"
  }
}

resource "azurerm_network_interface" "mynic"
{
  name="table5ratfvmnic"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  location="${var.location}"
  ip_configuration {
    name="ipconfig1"
    subnet_id="${azurerm_subnet.mysub.id}"
    private_ip_address_allocation="dynamic"
  }
  tags {
    environment="testing"
  }
}

resource "azurerm_virtual_machine" "myvm"
{
  name="table5ratfvm"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  network_interface_ids=["${azurerm_network_interface.mynic.id}"]
  vm_size="Standard_DS1_v2"

  storage_image_reference {
    publisher="Canonical"
    offer="UbuntuServer"
    sku="16.04-LTS"
    version="latest"
  }

  storage_os_disk {
    name="table5ratfvmdisk"
    caching="ReadWrite"
    create_option="FromImage"
    managed_disk_type="Standard_LRS"
  }

  os_profile {
    computer_name="table5ravm"
    admin_username="azureops"
    admin_password="Password1234!!!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    environment = "testing"
  }
}

