#!/bin/bash

# Importing functions run_as_root, get_os_version and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Installing Srm
if [[ ("$(get_os_version)" == "9") && (("$(get_os_type)" == "almalinux") || ("$(get_os_type)" == "centos") || ("$(get_os_type)" == "rhel")) ]]; then
    dnf install --assumeyes https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/srm-1.2.15-12.el8.x86_64.rpm
else
    dnf install --assumeyes srm
fi
