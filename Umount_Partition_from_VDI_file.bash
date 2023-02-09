#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo)" ]; then
      sudo bash "$0"
      exit $?
    else
      echo "Sudo is not installed"
      exit 1
    fi
  fi
}

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