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

# Getting all dnf packages
dnf_packages="$(sudo dnf list --upgrades)"

# Formatting string
dnf_packages="$(echo "$dnf_packages" | awk '{print $1}')"
to_be_replaced="Installed"
to_replace=""
dnf_packages="${dnf_packages/$to_be_replaced/$to_replace}"

# Reinstalling package by package
for i in $dnf_packages ; do
  sudo dnf upgrade --assumeyes "$i"
done
