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

# Installing systemd-timesyncd
dnf install --assumeyes systemd-timesyncd

# Enabling NTP service
systemctl enable systemd-timesyncd
timedatectl set-ntp yes

# Backing up configuration file
cp "/etc/systemd/timesyncd.conf" "/etc/systemd/timesyncd.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating new configuration file
{
  echo "[Time]"
  echo "NTP=a.st1.ntp.br b.st1.ntp.br c.st1.ntp.br d.st1.ntp.br gps.ntp.br a.ntp.br b.ntp.br c.ntp.br" # Using NTP.br servers
} > "/etc/systemd/timesyncd.conf"

# Restarting NTP service
systemctl restart systemd-timesyncd