#!/bin/bash
# Upgrades Fedora to a specific version

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

if [ "$(get_os_type)" == "fedora" ]; then
  dnf upgrade --refresh --assumeyes
  dnf install dnf-plugin-system-upgrade --assumeyes
  dnf system-upgrade download --releasever="$1" --assumeyes
  dnf system-upgrade reboot --assumeyes
fi