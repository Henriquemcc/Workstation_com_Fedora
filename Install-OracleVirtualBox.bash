#!/bin/bash

# Removing VirtualBox packages from other repositories
sudo dnf autoremove --assumeyes --repoid rpmfusion-free VirtualBox VirtualBox-kmodsrc VirtualBox-server akmod-VirtualBox kmod-VirtualBox

# Downloading and registering Oracle VirtualBox Key
wget https://www.virtualbox.org/download/oracle_vbox.asc
sudo rpm --import ./oracle_vbox.asc
gio trash ./oracle_vbox.asc

# Adding Oracle VirtualBox Repository
wget "https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo"
sudo mv ./virtualbox.repo /etc/yum.repos.d/virtualbox.repo

# Installing VirtualBox
sudo dnf install --assumeyes --repoid virtualbox VirtualBox-6.1
sudo /sbin/vboxconfig