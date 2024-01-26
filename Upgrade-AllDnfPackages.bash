#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Getting all dnf packages
dnf_packages="$(sudo dnf list --upgrades)"

# Formatting string
dnf_packages="$(echo "$dnf_packages" | awk '{print $1}')"
to_be_replaced="Installed"
to_replace=""
dnf_packages="${dnf_packages/$to_be_replaced/$to_replace}"

# Reinstalling package by package
for i in $dnf_packages ; do
  sudo dnf upgrade --assumeyes "$i"
done
