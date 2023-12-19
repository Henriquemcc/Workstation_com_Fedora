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

# Installing Flatpak if it is not installed
if ! [ "$(command -v flatpak)" ]; then
    bash ./Install-Flatpak.bash
fi

# Installing firefox from flatpak
flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.mozilla.firefox.flatpakref

# Removing firefox from RPM
dnf autoremove --assumeyes firefox