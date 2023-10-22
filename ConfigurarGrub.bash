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
cp "/etc/default/grub" "/etc/default/grub.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating new configuration file
{
  echo "GRUB_TIMEOUT=5"
  echo "GRUB_DISTRIBUTOR=\"$(sed 's, release .*$,,g' /etc/system-release)"\"
  echo "GRUB_DEFAULT=saved"
  echo "GRUB_DISABLE_SUBMENU=true"
  echo "GRUB_TERMINAL_OUTPUT=\"console\""
  echo "GRUB_CMDLINE_LINUX=\"rhgb quiet modprobe.blacklist=nouveau rd.driver.blacklist=nouveau\""
  echo "GRUB_DISABLE_RECOVERY=\"true\""
  echo "GRUB_ENABLE_BLSCFG=true"
  echo "GRUB_SAVEDEFAULT=true"
} > "/etc/default/grub"

# Generating grub
grub2-mkconfig -o /etc/grub2.cfg
grub2-mkconfig -o /etc/grub2-efi.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg