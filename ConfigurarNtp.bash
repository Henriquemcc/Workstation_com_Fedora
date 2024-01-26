#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

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