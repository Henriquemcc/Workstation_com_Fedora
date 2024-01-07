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

# Installing Open SSH Server
dnf install --assumeyes openssh-server

# Backing up configuration file
cp "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating new configuration file
{
  echo "Include /etc/ssh/sshd_config.d/*.conf"
  echo "PubkeyAuthentication yes"
  echo "AuthorizedKeysFile	.ssh/authorized_keys"
  echo "PasswordAuthentication no"
  echo "Subsystem	sftp	/usr/libexec/openssh/sftp-server"
} > "/etc/ssh/sshd_config"

# Restarting sshd
systemctl restart sshd