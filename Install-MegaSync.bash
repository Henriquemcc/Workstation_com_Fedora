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

# Installation variables
VERSION_ID="$(awk -F= '$1=="VERSION_ID" { print $2 ;}' /etc/os-release)"
ARCHITECTURE="$(uname -m)"

# Installing Mega Sync
dnf install "https://mega.nz/linux/repo/Fedora_${VERSION_ID}/${ARCHITECTURE}/megasync-Fedora_${VERSION_ID}.${ARCHITECTURE}.rpm"