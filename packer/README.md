# Pre-requirements
- The template used need to have qemu-guest-agent installed
- The template used must have a cloud-init drive
- The template used must have the network set as DHCP in cloud-init parameters
- You should perform an initial cloud-init before running packer

Packer will automatically 

as root [TO DO => change permissions]: 
docker exec -it --user root packer-packer-1 bash
packer init templates/main.pkr.hcl

as user : 
docker exec -it packer-packer-1 bash
packer build -on-error=ask -var-file variables/proxmox/ubuntu2404-lamp.pkvars.hcl templates/main.pkr.hcl