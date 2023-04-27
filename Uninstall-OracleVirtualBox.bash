#!/bin/bash

# Removing VirtualBox package
sudo dnf autoremove --assumeyes virtualbox VirtualBox-7.0

# Removing VirtualBox repository
sudo rm /etc/yum.repos.d/virtualbox.repo
