variable "PROXMOX_URL" {
  type = string
  default = env("PROXMOX_URL")
}

variable "PROXMOX_USERNAME" {
  type = string
  default = env("PROXMOX_USERNAME")
}

variable "PROXMOX_TOKEN" {
  type = string
  sensitive = true
  default = env("PROXMOX_TOKEN")
}

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

source "proxmox-clone" "linux-server" {
  #### Global settings
  task_timeout = "5m"

  #### Hypervisor connection
  proxmox_url = var.PROXMOX_URL
  username = var.PROXMOX_USERNAME
  token = var.PROXMOX_TOKEN
  insecure_skip_tls_verify = true

  #### origin VM
  node = "pve-01"
  clone_vm = "packer-base" # or use clone_vm_id = 106

  #### Dest VM
  vm_name = "packer-build"
  memory = 2048
  cores = 2
  scsi_controller = "virtio-scsi-single"
  os = "l26" # Linux 2.6+
  tags = "Packer;Debian-13;Linux"

  #### SSH provisioning
  ssh_username = "demo"
  ssh_private_key_file = "./ssh/id_rsa"
  ssh_timeout = "10m"

  #### Dest template
  template_name = "packer-build-test"
  template_description = "Built by HashiCorp Packer on ${local.buildtime}"
}

build {
  sources = ["source.proxmox-clone.linux-server"]
  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install apache2 unzip -y",
      "wget -O /tmp/massively.zip https://html5up.net/massively/download --no-check-certificate",
      "sudo rm /var/www/html/index.html",
      "sudo unzip /tmp/massively.zip -d /var/www/html/",
      "sudo chown -R www-data:www-data /var/www/html"
    ]
  }
}