#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Path to the destination device file where the vdi file will be mounted
destination_device_path="/dev/nbd0"

# Trying to unmount vdi file
while true; do
  # Unmounting vdi file
  qemu-nbd --disconnect "$destination_device_path" && break
done

while true; do
  # Removing Module NBD
  rmmod nbd && break
done