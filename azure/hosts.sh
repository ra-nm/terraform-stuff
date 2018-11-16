#!/bin/sh

vm_ip=$(terraform output -state=/ssh/terraform.tfstate vm_ip)
echo $vm_ip
echo "host1 ansible_user=azureops ansible_ssh_private_key_file=/ssh/id_rsa ansible_ssh_host="$vm_ip > /ssh/inventory
echo "" >> /ssh/inventory
echo "[apache]" >> /ssh/inventory
echo "host1" >> /ssh/inventory
