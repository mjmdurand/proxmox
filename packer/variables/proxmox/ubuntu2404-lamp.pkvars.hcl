##################################################################################
# VARIABLES
##################################################################################

#### Clone & template settings
node                 = "pve-01"
clone_vm             = "ubuntu2404-cloud" # or use clone_vm_id = 106
vm_name              = "packer-ubuntu2404-lamp-build"
template_name        = "ubuntu2404-lamp"
vm_id                = 951

#### VM Settings
memory               = 2048
cores                = 2
scsi_controller      = "virtio-scsi-single"
os                   = "l26" # Linux 2.6+
tags                 = "Packer;Ubuntu-24_04;Ubuntu;Linux;LAMP"

#### SSH provisioning
ssh_username         = "demo"
ssh_private_key_file = "./ssh/id_rsa"

#### Ansible provisioning
playbook_file        = "ansible/playbooks/lamp.yml"
inventory_directory  = "ansible/inventories/"
groups               = ["ubuntu"]