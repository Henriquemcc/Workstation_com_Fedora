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

# Creating wireguard configuration directory and changing the current directory to it
mkdir -p /etc/wireguard

# Setting permission
umask 077

# Generating server keys
bash ./Generate-ServerKeys.bash

# Generating server configuration
bash ./Generate-ServerConfiguration.bash

# Copying server configuration file
cp ./wg0.conf /etc/wireguard/wg0.conf

# Opening Firewall port
firewall-cmd --permanent --add-service=wireguard
firewall-cmd --reload

# Enabling IP Forwarding
if ! grep -q "net.ipv4.ip_forward=1" "/etc/sysctl.conf"; then
  echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
fi
if ! grep -q "net.ipv6.conf.all.forwarding=1" "/etc/sysctl.conf"; then
  echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.conf
fi

# Starting and enabling wireguard service
systemctl enable wg-quick@wg0.service
systemctl daemon-reload
systemctl start wg-quick@wg0
