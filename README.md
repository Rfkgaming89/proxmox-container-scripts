Is a work in progrese. please let me know if any errors happen or if something doesn't work. 

# Proxmox Container Creation Script

This script automates the creation of a new Proxmox Container (CT) using a specified template, storage, CPU and memory allocation, and network settings. 

It also automatically selects the next available IP address based on the previous container's IP address.

## Requirements

- Proxmox VE installation
- `sshpass` package installed on the machine running the script (e.g. `sudo apt install sshpass`)

## Usage

1. Copy the contents of the script into a file and save it with a `.sh` file extension (e.g. `create-container.sh`).
2. Set the value of the `password` variable to the desired password for the container.
3. Run the script with `sudo` or as the root user: `sudo ./create-container.sh`
4. The script will prompt for the container's hostname, and then create the container using the specified settings.
5. After the container is started, the script will prompt for the root password to log in to the container, and then automatically run the `apt update && apt upgrade -y && apt install curl` command.

Note: The script assumes that the `vmbr0` bridge is used for the container's network interface. If a different bridge is used, update the `network` variable accordingly.

## Script settings

The following variables can be adjusted in the script:

- `password`: The password for the container's root user.
- `template`: The name of the template to use for the container. Defaults to `debian-11-standard_11.6-1_amd64.tar.zst`.
- `storage`: The name of the storage to use for the container's disk. Defaults to `local-lvm`.
- `disk_size`: The size of the container's root filesystem. Defaults to `10G`.
- `cpu_count`: The number of virtual CPUs to allocate to the container. Defaults to `1`.
- `ram_size`: The amount of RAM to allocate to the container, in MB. Defaults to `512`.
- `network`: The name of the bridge to use for the container's network interface. Defaults to `vmbr0`.
- `ipv4_subnet`: The IPv4 subnet to use for the container's network interface, in CIDR notation. Defaults to `192.168.1.1/24`.
- `ipv6_subnet`: The IPv6 subnet to use for the container's network interface, in CIDR notation. Defaults to `Ffff:c0a8:101::/64`.
- `dns_servers`: A space-separated list of DNS server IP addresses to use for the container. Defaults to `8.8.8.8 8.8.4.4`.

## Troubleshooting

If the script fails with a message indicating that `sshpass` is not installed, install it using the command: `sudo apt install sshpass`. 

If the script fails with a message indicating that the specified storage or template cannot be found, verify that the storage or template name is correct and exists on the Proxmox server.

If the script fails with a message indicating that the container could not be started or accessed via SSH, check the Proxmox server logs for any errors that may have occurred during the container creation process.
