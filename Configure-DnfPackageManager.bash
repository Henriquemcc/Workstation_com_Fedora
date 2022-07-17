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

# Backing up configuration file
cp "/etc/dnf/dnf.conf" "/etc/dnf/dnf.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

{
  echo "[main]"
  echo "gpgcheck=1"
  echo "installonly_limit=3"
  echo "clean_requirements_on_remove=True"
  echo "best=False"
  echo "skip_if_unavailable=True"

  # Keeping cached packages
  echo "keepcache=True"

  # Using the fastest mirror
  echo "fastestmirror=True"
} > "/etc/dnf/dnf.conf"