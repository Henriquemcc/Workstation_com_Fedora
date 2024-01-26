#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Backing up configuration file
cp "/etc/default/grub" "/etc/default/grub.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating new configuration file
if ! grep -q "GRUB_SAVEDEFAULT=true" "/etc/default/grub"; then
  echo "GRUB_SAVEDEFAULT=true" >> "/etc/default/grub"
fi

# Generating grub
grub2-mkconfig -o /etc/grub2.cfg
grub2-mkconfig -o /etc/grub2-efi.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg