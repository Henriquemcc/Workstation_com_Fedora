#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Installing RPM Fusion
if [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ]; then
  dnf install --assumeyes --nogpgcheck "https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm"
  dnf install --assumeyes --nogpgcheck "https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm"
elif [ "$(get_os_type)" == "fedora" ]; then
  dnf install --assumeyes "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
  dnf install --assumeyes "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
fi
dnf install --assumeyes rpmfusion-free-release-tainted
dnf install --assumeyes rpmfusion-nonfree-release-tainted

# Using openh264 library
if [ "$(get_os_type)" == "fedora" ]; then
  dnf config-manager --enable --assumeyes fedora-cisco-openh264
fi
