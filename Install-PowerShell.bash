#!/bin/bash

# Variables
version="7.4.1"
subversion="1"

# Importing function run_as_root, get_os_type and get_os_version
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Register the Microsoft RedHat repository
curl -sSL -O "https://packages.microsoft.com/config/$(get_os_type)/$(get_os_version)/packages-microsoft-prod.rpm"

# Register the Microsoft repository keys
rpm -i packages-microsoft-prod.rpm

# Delete the repository keys after installing
rm packages-microsoft-prod.rpm

# Installing PowerShell
if [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ]; then
  dnf install --assumeyes powershell
elif [ "$(get_os_type)" == "fedora" ]; then
  dnf install --assumeyes https://github.com/PowerShell/PowerShell/releases/download/v${version}/powershell-${version}-${subversion}.rh.x86_64.rpm
fi