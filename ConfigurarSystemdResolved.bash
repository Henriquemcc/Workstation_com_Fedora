#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing systemd-resolved
dnf install --assumeyes systemd-resolved

# Enabling systemd-resolved service
systemctl enable --now systemd-resolved.service

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
