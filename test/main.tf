resource "null_resource" "run-ansible" 
{
  provisioner "local-exec" {
    command = "echo 'Hello World'"
  }
}

