- Mount command : 
```bash
sudo mount -t ceph 10.0.0.1,10.0.0.2,10.0.0.3:/ /mnt/cephfs \
-o name=admin,secretfile=/etc/ceph/admin.keyring,fsid=b5a50d7e-08db-496f-821e-c3dc75b61b76
```