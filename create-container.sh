#!/bin/bash

# Define variables
TEMPLATE_LOCATION=/mnt/pve/Backup/template/cache
TEMPLATE_FILE=debian-11-standard_11.6-1_amd64.tar.zst
PASSWORD="your_password_here"
CORES=1
MEMORY=512
DISK_SPACE=10G
STORAGE_DISK=Storage

# Determine last container number
LAST_CT_NUM=$(pct list | awk 'NR>1 {print $1}' | sort -n | tail -1)

# Increment last container number to get new container number
NEW_CT_NUM=$((LAST_CT_NUM + 1))

# Ask for hostname
read -p "Enter hostname for new container: " HOSTNAME

# Create new container
pct create $NEW_CT_NUM $TEMPLATE_LOCATION/$TEMPLATE_FILE --hostname $HOSTNAME --password $PASSWORD --cores $CORES --memory $MEMORY --storage $STORAGE_DISK --rootfs $STORAGE_DISK:10 --onboot 1

# Enable keyctl
pct set $NEW_CT_NUM --keyctl yes

# Start container
pct start $NEW_CT_NUM

# Run updates and install curl
pct exec $NEW_CT_NUM -- apt update && apt upgrade -y && apt install curl -y

# Enable root login via SSH
pct exec $NEW_CT_NUM -- sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
pct exec $NEW_CT_NUM -- service ssh restart

# Print completion message
echo "Container $NEW_CT_NUM created and updates applied."
