# Proxmox node et VM source
proxmox_node  = "pve1"
source_vm_id  = 100
template_name = "ubuntu-cloudinit-template"

# Cloud-Init : fichiers uploadés dans /var/lib/vz/snippets/
ci_custom = "user=cephfs:snippets/user-data-debian.yml,vendor=cephfs:snippets/vendor-data.yml,network=cephfs:snippets/network-data.yml"
