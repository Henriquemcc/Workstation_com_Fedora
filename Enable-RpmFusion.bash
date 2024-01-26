#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing RPM Fusion
dnf install --assumeyes https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install --assumeyes https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install --assumeyes rpmfusion-free-release-tainted
dnf install --assumeyes rpmfusion-nonfree-release-tainted

# Using openh264 library
dnf config-manager --enable --assumeyes fedora-cisco-openh264
