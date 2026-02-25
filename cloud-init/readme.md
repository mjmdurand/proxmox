1) enable snippets

![Enable snippets](img/enable_snippets.png)
![check snippets](img/check_enabled_snippets.png)

2) create/upload the cloud-init files

  a) with shell
  ```bash
  cd /var/lib/vz/snippets
  nano user-data.yml
  ...
  ...
  ...
  ```
  b) or use you own software to, upload them through SSH in `/var/lib/vz/snippets

![snippets exists](img/snippets_exists.png)

3) Get your cloud image : 
    - Debian : https://cloud.debian.org/images/cloud/ (example : https://cloud.debian.org/images/cloud/trixie/20260220-2394/debian-13-generic-amd64-20260220-2394.qcow2)
    - Ubuntu : https://cloud-images.ubuntu.com/ (example : https://cloud-images.ubuntu.com/jammy/20260219/jammy-server-cloudimg-amd64.img) **you have to change the extension to .qcow2 in order to use this image**

![download from url](img/download_image.png)
![upload image](img/upload_image.png)

4) Create a new VM

![create VM 01](img/create_VM_1.png)
![create VM 02](img/create_VM_2.png)
![create VM 03](img/create_VM_2b.png)
![create VM 04](img/create_VM_3.png)
![create VM 05](img/create_VM_4.png)
![create VM 06](img/create_VM_5.png)
![create VM 07](img/create_VM_6.png)
![create VM 08](img/create_VM_7.png)

5) Add Cloud-init drive

![create CI drive 01](img/CI_drive_1.png)
![create CI drive 02](img/CI_drive_2.png)

6) Renseigner les fichiers à utiliser via le shell et générer l'image ISO
```bash
qm set 101 --cicustom "user=local:snippets/user-data.yml,vendor=local:snippets/vendor-data.yml,network=local:snippets/network-data.yml"
qm cloudinit update 101
```

![assign CI files](img/assign_CI_files.png)

7) Convertir la VM en template pour pouvoir la réutiliser au besoin

![create template](img/template.png)

8) créer une nouvelle VM a partir du template

![clone template 01](img/clone_template_1.png)
![clone template 02](img/clone_template_2.png)


9) demarrer la VM, le cloud init s'effectue

![CI done 01 ](img/CI_done_1.png)
![CI done 02 ](img/CI_done_2.png)

10) après reboot, l'agent est bien fonctionnel

![CI done 03 ](img/CI_done_3.png)
