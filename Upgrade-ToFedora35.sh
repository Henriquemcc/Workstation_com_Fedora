#!/bin/bash
# Upgrades to Fedora 35

sudo dnf upgrade --refresh --assumeyes
sudo dnf install dnf-plugin-system-upgrade --assumeyes
sudo dnf system-upgrade download --releasever=35 --assumeyes
sudo dnf system-upgrade reboot --assumeyes