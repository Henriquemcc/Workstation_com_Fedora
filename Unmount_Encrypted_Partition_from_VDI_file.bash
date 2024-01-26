#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Path to the destination device file where the vdi file will be mounted
destination_device_path="/dev/nbd0"

# Trying to unmount encrypted partition
while true; do
  # Unmounting encrypted partition
  udisks --unmount /dev/mapper/my_encrypted_volume && break
done

# Trying to close encrypted device
while true; do
  # Closing encrypted device
  cryptsetup luksClose my_encrypted_volume && break
done

# Trying to unmount vdi file
while true; do
  # Unmounting vdi file
  qemu-nbd --disconnect "$destination_device_path" && break
done

while true; do
  # Removing Module NBD
  rmmod nbd && break
done