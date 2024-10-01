#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Exiting if the operating system is not Red Hat or CentoOS
if [ "$(get_os_type)" != "rhel" ] && [ "$(get_os_type)" != "centos" ] && [ "$(get_os_type)" != "almalinux" ]&& [ "$(get_os_type)" != "ol" ]; then
  echo "This script is only for Red Hat, CentOS, Almalinux or Oracle Linux."
  exit 1
fi

# Running as root
run_as_root

# Installing Fedora Epel
dnf install --assumeyes --nogpgcheck "https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm"
