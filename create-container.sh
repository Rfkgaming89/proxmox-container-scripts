#!/bin/bash

# Define variables
password="your_password"
template="debian-11-standard_11.6-1_amd64.tar.zst"
storage="local-lvm"
disk_size="10G"
cpu_count="1"
ram_size="512"
network="vmbr0"
ipv4_subnet="192.168.1.1/24"
ipv6_subnet="2a02:1234:5678:9abc::/64"
dns_servers="8.8.8.8 8.8.4.4"

# Find the next available IP address based on the previous one
last_ip="$(cat /etc/pve/nodes/*/lxc/*.conf | grep "ip_address" | awk '{print $NF}' | sort -rn | head -n1)"
if [ -z "$last_ip" ]; then
    next_ip="$(echo $ipv4_subnet | cut -d'.' -f1-3).2"
else
    next_ip="$(echo $last_ip | awk -F. '{print $1,$2,$3,$4+1}' OFS=.)"
fi

# Ask for hostname
read -p "Enter hostname: " hostname

# Create the container
pct create $(expr $(pct list | grep CT | wc -l) + 100) -hostname $hostname -password $password -net0 name=eth0,bridge=$network,ip=$ipv4_subnet,ip6=$ipv6_subnet,gw=192.168.1.1,ip6-gw=2a02:1234:5678:9abc::1 -ostemplate $template -storage $storage -rootfs $disk_size -memory $ram_size -cpus $cpu_count

# Enable keyctl
pct set $(expr $(pct list | grep CT | wc -l) + 100) -onboot 1 -startup keyctl

# Start the container
pct start $(expr $(pct list | grep CT | wc -l) + 100)

# Ask for login password
read -p "Enter login password: " login_password

# Log in to the container and run commands
sshpass -p "$login_password" ssh root@$next_ip <<EOF
apt update
apt upgrade -y
apt install curl -y
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
service ssh restart
EOF
