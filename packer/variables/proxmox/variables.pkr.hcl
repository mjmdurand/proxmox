# Proxmox API
variable "proxmox_url" {
  type = string
}

variable "proxmox_user" {
  type = string
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  type = string
}

# VM source
variable "source_vm_id" {
  type = number
}

# Template
variable "template_name" {
  type = string
}

# Cloud-Init
variable "ci_custom" {
  type = string
}
