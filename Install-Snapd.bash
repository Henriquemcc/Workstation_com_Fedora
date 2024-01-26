#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Snap package manager
dnf install --assumeyes snapd

# Enabling Snapd
systemctl enable --now snapd.socket

# Enabling classic snap support
ln -s /var/lib/snapd/snap /snap

# Installing Kernel modules
dnf install --assumeyes fuse
dnf install --assumeyes squashfuse
dnf install --assumeyes kernel-modules

# Installing snap core
snap install core

# Updating snap core
snap refresh core