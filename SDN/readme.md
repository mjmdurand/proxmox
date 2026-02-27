# Install required
- https://pve.proxmox.com/wiki/Setup_Simple_Zone_With_SNAT_and_DHCP
```bash
apt install dnsmasq
systemctl stop dnsmasq
systemctl disable dnsmasq
```

- VXLAN explained : https://blog.zwindler.fr/2025/03/30/tutoriel-sdn-vxlan-proxmoxve-8/