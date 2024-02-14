#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing firewalld
dnf install --assumeyes firewalld

# Closing all open ports by default
firewall-cmd --permanent --remove-port=1025-65535/tcp
firewall-cmd --permanent --remove-port=1025-65535/udp

# Reloading
firewall-cmd --permanent --reload