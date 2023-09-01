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
cp "/etc/systemd/resolved.conf" "/etc/systemd/resolved.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating new configuration file
{
  echo "[Resolve]"
  echo "DNSSEC=allow-downgrade"
  echo "DNSOverTLS=opportunistic"
  echo "Cache=yes"
} > "/etc/systemd/resolved.conf"

# Restarting systemd-resolve
systemctl restart systemd-resolved.service