#!/bin/sh

vm_ip=$(terraform output vm_ip)
echo $vm_ip
echo "host1 ansible_user=azureops ansible_ssh_host="$vm_ip > /ssh/inventory

