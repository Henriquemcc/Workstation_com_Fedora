#!/bin/bash

# Removing VirtualBox package
sudo dnf autoremove --assumeyes virtualbox VirtualBox-6.1

# Removing VirtualBox repository
sudo rm /etc/yum.repos.d/virtualbox.repo
