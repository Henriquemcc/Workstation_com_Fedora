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

# Installing requirements
dnf install  --assumeyes 'dnf-command(config-manager)'
dnf install --assumeyes git
dnf install --assumeyes git-lfs

# Adding GitHub Cli repository
dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo --assumeyes

# Installing GitHub Cli.
dnf install --assumeyes gh