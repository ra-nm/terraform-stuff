resource "azurerm_network_interface" "mynic"
{
  name="table5ratfvmnic"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  location="${var.location}"
  ip_configuration {
    name="ipconfig1"
    subnet_id="${azurerm_subnet.mysub.id}"
    private_ip_address_allocation="dynamic"
    public_ip_address_id="${azurerm_public_ip.myip.id}"
  }
  tags {
    environment="testing"
  }
}

resource "random_id" "randomid"
{
  keepers = {
    resource_group="${azurerm_resource_group.thegroup.name}"
  }
  byte_length=8
}

resource "azurerm_storage_account" "mystorage"
{
  name="diag${random_id.randomid.hex}"
  location="${var.location}"
  resource_group_name="${azurerm_resource_group.thegroup.name}"
  account_tier="Standard"
  account_replication_type="LRS"
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
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path="/home/azureops/.ssh/authorized_keys"
      key_data="${file("/ssh/id_rsa.pub")}"
    }
  }

  boot_diagnostics {
    enabled="true"
    storage_uri="${azurerm_storage_account.mystorage.primary_blob_endpoint}"
  }

  tags {
    environment = "testing"
  }
  
}

