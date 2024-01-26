#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root "$@"

# Path to the file
vdi_file_path="$1"

# Reading from user input if the arguments to the file path does not exist
if ! [ -f "$vdi_file_path" ]; then
  read -p "VDI file path: " -r vdi_file_path
fi

# Debug
echo "VDI file path: $vdi_file_path"

# Exiting if the vdi file does not exist
if ! [ -f "$vdi_file_path" ]; then
  echo "VDI file does not exist"
  exit 1
fi

# Installing requirements
dnf install cryptsetup --assumeyes
dnf install udisks --assumeyes

# Path to the destination device file where the vdi file will be mounted
destination_device_path="/dev/nbd0"

# Mounting file if the device does not exist
if ! [ -f "$destination_device_path" ]; then
  # Removing Module NBD
  rmmod nbd

  # Adding Module NBD
  modprobe nbd max_part=1

  # Mounting vdi file
  qemu-nbd --connect "$destination_device_path" "$vdi_file_path"
fi

# Trying to open encrypted device
while true; do
  # Opening encrypted device
  cryptsetup luksOpen "$destination_device_path" my_encrypted_volume && break
done

# Mounting encrypted partition
udisks --mount /dev/mapper/my_encrypted_volume
