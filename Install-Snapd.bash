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

# Installing Snap package manager
dnf install --assumeyes snapd
ln -s /var/lib/snapd/snap /snap

# Installing Kernel modules
dnf install --assumeyes fuse
dnf install --assumeyes squashfuse
dnf install --assumeyes kernel-modules

# Installing snap core
snap install core

# Updating snap core
snap refresh core