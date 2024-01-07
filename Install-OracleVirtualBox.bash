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

# Removing RPM Fusion's VirtualBox
bash ./Uninstall-VirtualBox.bash

# Downloading and registering Oracle VirtualBox Key
rpm --import https://www.virtualbox.org/download/oracle_vbox.asc

# Adding Oracle VirtualBox Repository
curl -L https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo --output virtualbox.repo
mv ./virtualbox.repo /etc/yum.repos.d/virtualbox.repo

# Installing VirtualBox
dnf install --assumeyes VirtualBox-7.0
