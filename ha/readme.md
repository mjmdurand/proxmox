# Maintenance mode
You can customize actions to perform when a node is offline/in maintenance mode in Datacenter => Options > HA
```bash
#Enable
ha-manager crm-command node-maintenance enable $(hostname)

#Disable
ha-manager crm-command node-maintenance disable $(hostname)
```

# HA Affinity rules
## HA Node affinity rule
Used to specify the node priority for the VM ; **higher number = higher priority** 

## HA Ressources affinity rules
Used to specify if VM should be kept together on the same node or separate them on différent nodes