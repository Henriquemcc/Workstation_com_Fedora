#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo)" ]; then
      sudo bash "$0"
      exit $?
    else
      echo "Sudo is not installed"
      exit 1
    fi
  fi
}

# Running as root
run_as_root

# Installing Docker Engine
bash ./Install-DockerEngine.bash

# Installing Docker desktop
dnf install --assumeyes https://desktop.docker.com/linux/main/amd64/docker-desktop-4.26.1-x86_64.rpm
