##################################################################################
# VARIABLES
##################################################################################

#### Clone & template settings
node                 = "pve-01"
clone_vm             = "packer-base" # or use clone_vm_id = 106
vm_name              = "packer-build"
template_name        = "packer-build-test"

#### VM Settings
memory               = 2048
cores                = 2
scsi_controller      = "virtio-scsi-single"
os                   = "l26" # Linux 2.6+
tags                 = "Packer;Debian-13;Linux;LAMP"

#### SSH provisioning
ssh_username         = "demo"
ssh_private_key_file = "./ssh/id_rsa"

#### Ansible provisioning
playbook_file        = "ansible/playbooks/lamp.yml"
inventory_directory  = "ansible/inventories/"
groups               = ["debian"]