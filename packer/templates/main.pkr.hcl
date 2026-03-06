##################################################################################
# VARIABLES
##################################################################################

#### Hypervisor connection
variable "PROXMOX_URL" {
  type    = string
  default = env("PROXMOX_URL")
}

variable "PROXMOX_USERNAME" {
  type    = string
  default = env("PROXMOX_USERNAME")
}

variable "PROXMOX_TOKEN" {
  type      = string
  sensitive = true
  default   = env("PROXMOX_TOKEN")
}

#### Clone & template settings
variable "node" {
  type        = string
  description = "The template node to clone from"
  default     = "pve-01"
}

variable "clone_vm" {
  type        = string
  description = "The template vm to clone from"
  default     = ""
}

variable "vm_name" {
  type        = string
  description = "The name of the Build VM to create"
  default     = ""
}

variable "template_name" {
  type        = string
  description = "The final template name"
  default     = ""
}

variable "vm_id" {
  type        = number
  description = "The ID of the VM/template to create"
  default     = null
}

#### VM Settings
variable "memory" {
  type        = number
  description = "The amount of memory for the VM."
  default     = 2048
}

variable "cores" {
  type        = number
  description = "The number of virtual CPUs."
  default     = 2
}

variable "scsi_controller" {
  type        = string
  description = "The SCSI controller type."
  default     = "virtio-scsi-single"
}

variable "os" {
  type        = string
  description = "The operating system type."
  default     = "l26"
}

variable "tags" {
  type        = string
  description = "The tags to apply to the VM."
  default     = ""
}

#### ANSIBLE SETTINGS
variable "playbook_file" {
  type        = string
  description = "The Ansible playbook file to use."
  default     = "ansible/playbooks/default.yml"
}

variable "inventory_directory" {
  type        = string
  description = "The Ansible inventory directory."
  default     = "ansible/inventories/"
}

variable "groups" {
  type        = list(string)
  description = "The Ansible groups to include the host in."
  default     = ["default"]
}

#### PACKER SETTINGS
locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

variable "ssh_username" {
  type        = string
  description = "The SSH username for the VM."
  default     = "ansible"
}

variable "ssh_private_key_file" {
  type        = string
  description = "The path to the SSH private key file."
  default     = "./ssh/id_rsa"
}


##################################################################################
# BUILDERS TO INSTALL
##################################################################################
packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

##################################################################################
# SOURCE
##################################################################################
source "proxmox-clone" "linux-server" {
  #### Global settings
  task_timeout = "5m"

  #### Hypervisor connection
  proxmox_url              = var.PROXMOX_URL
  username                 = var.PROXMOX_USERNAME
  token                    = var.PROXMOX_TOKEN
  insecure_skip_tls_verify = true

  #### origin VM
  node     = var.node
  clone_vm = var.clone_vm

  #### Dest VM
  vm_name         = var.vm_name
  memory          = var.memory
  cores           = var.cores
  scsi_controller = var.scsi_controller
  os              = var.os
  tags            = var.tags
  vm_id           = var.vm_id

  #### SSH provisioning
  ssh_username         = var.ssh_username
  ssh_private_key_file = var.ssh_private_key_file
  ssh_timeout          = "10m"

  #### Dest template
  template_name        = var.template_name
  template_description = "Built by HashiCorp Packer on ${local.buildtime}"
}

##################################################################################
# BUILD
##################################################################################

build {
  sources = ["source.proxmox-clone.linux-server"]
  provisioner "ansible" {
    playbook_file       = var.playbook_file
    galaxy_file         = "ansible/requirements.yml"
    roles_path          = "ansible/roles"
    inventory_directory = var.inventory_directory
    groups              = var.groups
    ansible_env_vars = [
      "ANSIBLE_CONFIG=ansible/ansible.cfg",
    ]
  }
  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install unzip -y",
      "wget -O /tmp/massively.zip https://html5up.net/massively/download --no-check-certificate",
      "sudo rm /var/www/html/index.html",
      "sudo unzip /tmp/massively.zip -d /var/www/html/",
      "sudo chown -R www-data:www-data /var/www/html"
    ]
  }
}