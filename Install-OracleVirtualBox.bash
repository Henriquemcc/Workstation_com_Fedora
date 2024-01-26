#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Removing RPM Fusion's VirtualBox
bash ./Uninstall-VirtualBox.bash

# Downloading and registering Oracle VirtualBox Key
rpm --import https://www.virtualbox.org/download/oracle_vbox.asc

# Adding Oracle VirtualBox Repository
curl -L https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo --output virtualbox.repo
mv ./virtualbox.repo /etc/yum.repos.d/virtualbox.repo

# Installing VirtualBox
dnf install --assumeyes VirtualBox-7.0
