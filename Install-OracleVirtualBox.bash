-#!/bin/bash

# Installing requirements
bash ./Install-GioTrash.bash

# Removing RPM Fusion's VirtualBox
bash ./Uninstall-VirtualBox.bash

# Downloading and registering Oracle VirtualBox Key
wget https://www.virtualbox.org/download/oracle_vbox.asc
sudo rpm --import ./oracle_vbox.asc
gio trash ./oracle_vbox.asc

# Adding Oracle VirtualBox Repository
wget "https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo"
sudo mv ./virtualbox.repo /etc/yum.repos.d/virtualbox.repo

# Installing VirtualBox
sudo dnf install --refresh --assumeyes VirtualBox-6.1
