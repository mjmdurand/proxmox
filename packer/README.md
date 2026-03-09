# Create the base template
- create a VM using a cloud disk
- Setup cloud-init drive
- Setup Cloud-init network on GUI => IPV4 DHCP auto
- Resize HDD (~10GB recommended)
- provide a basic cloud-init file to allow packer to get the VM IP : 

user-data.yml
```yaml 
#cloud-config

hostname: ubuntu2404-ci
manage_etc_hosts: true

ssh_pwauth: false

users:
  - name: demo
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    lock_passwd: false
    passwd: $6$5NcXlX36dm0YnHri$e28vjgEHVYqxA16z/cbt0iw4lwVJPCUUAJcsFExMp3oXd4bSVxabKVR3sd0Apd6uqDG8FkxqSNMHrkQp3LsPm/
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1....... demo
  - default

locale: fr_FR.UTF-8
timezone: Europe/Paris

keyboard:
  layout: fr
  variant: nodeadkeys

package_update: true
package_upgrade: true

packages:
  - qemu-guest-agent
```

vendor-data.yml
```yaml
#cloud-config
runcmd:
    - reboot
```

```bash
qm set 901 --cicustom "user=cephfs:snippets/user-data-ubuntu.yml,vendor=cephfs:snippets/vendor-data.yml"
qm cloudinit update 901
```
- Convert the VM to a template

# Build the golden image with Packer
- Customize ansible playbooks & inventory in the `ansible` directory
- Customize the template to create with .pkvars.hcl
- Run packer build
```bash
docker compose up -d
docker exec -it packer-packer-1 packer init templates/proxmox-clone.pkr.hcl
docker exec -it packer-packer-1 packer build -on-error=ask -var-file variables/proxmox/debian13-lamp.pkvars.hcl templates/proxmox-clone.pkr.hcl

## to force existing VM deletion
docker exec -it packer-packer-1 packer build -force -on-error=ask -var-file variables/proxmox/debian13-lamp.pkvars.hcl templates/proxmox-clone.pkr.hcl
```