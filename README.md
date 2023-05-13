# README

This is a Bash script that automates the creation of a new Proxmox container based on a Debian template. The script allows you to configure various parameters, such as the container's hostname, the amount of CPU cores, memory, and disk space, the location of the template file, and the storage location for the container. Additionally, the script applies updates, installs curl, and enables root login via SSH on the new container.

## Usage

To use the script, follow these steps:

1. Copy the script to your Proxmox host, and make it executable by running `chmod +x script_name.sh`.

2. Open the script in a text editor and modify the variables to match your requirements. The variables are defined at the top of the script, and you can change their values to suit your needs. 

3. Save the changes you made to the script.

4. Run the script by running `./script_name.sh`.

5. When prompted, enter the hostname for the new container.

6. Wait for the script to complete. When it's done, it will print a message indicating that the container has been created, and updates have been applied.

## Variables

The following variables can be modified to customize the behavior of the script:

- `TEMPLATE_LOCATION`: The location of the template file. By default, it is set to `/mnt/pve/Backup/template/cache`.

- `TEMPLATE_FILE`: The name of the template file. By default, it is set to `debian-11-standard_11.6-1_amd64.tar.zst`.

- `PASSWORD`: The password for the new container's root user.

- `CORES`: The number of CPU cores to allocate to the new container. By default, it is set to 1.

- `MEMORY`: The amount of memory (in MB) to allocate to the new container. By default, it is set to 512.

- `DISK_SPACE`: The amount of disk space to allocate to the new container. By default, it is set to `10G`.

- `STORAGE_DISK`: The name of the storage disk to use for the new container. By default, it is set to `Storage`.

## 
Changing the storage location:
The --storage option in the pct create command specifies the storage location where the container's disk image will be stored. To change the storage location, edit the STORAGE_DISK variable in the script. For example, if you want to use a storage location named my-storage, change the line to:

STORAGE_DISK=my-storage

Changing the disk space:
The --rootfs option in the pct create command specifies the disk space allocated to the container's root file system. To change the disk space, edit the DISK_SPACE variable in the script. The value should be in the format size[unit], where size is a positive integer and unit is a letter representing the size unit (e.g. M for megabytes, G for gigabytes, etc.). For example, if you want to allocate 20 gigabytes of disk space, change the line to:

makefile

    DISK_SPACE=20

Once you have made the changes, save the script and run it. The new container will be created with the specified storage location and disk space.

## Note

This script assumes that you have a valid Proxmox environment set up, and that you have the necessary permissions to create containers. Additionally, this script does not perform any error handling or input validation, so use it at your own risk.
