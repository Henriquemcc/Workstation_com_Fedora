#!/bin/bash

# Commands to run as root
function run_with_root_privileges()
{
  dnf upgrade --refresh --assumeyes
  snap refresh
  flatpak update --assumeyes
}

# Command to run as user
function run_without_root_privileges()
{
  flatpak update --assumeyes
}

# Detecting whether it is running as root or user
if [ "$(whoami)" == "root" ]; then
    run_without_root_privileges

    # Running as non-root user
    sudo -u "$SUDO_USER" bash -c "$(declare -f run_without_root_privileges); run_without_root_privileges"
else
  # Running as root
  sudo bash -c "$(declare -f run_with_root_privileges); run_with_root_privileges"

  run_without_root_privileges
fi