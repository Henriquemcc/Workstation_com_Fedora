#!/bin/bash

# Uninstalling Oracle VirtualBox
bash ./Uninstall-OracleVirtualBox.bash

# Enabling RPM fusion
bash ./Enable-RpmFusion.bash

# Installing VirtualBox
if ! [ "$(command -v virtualbox)" ]; then
  sudo dnf install --assumeyes VirtualBox
  sudo dnf install --assumeyes virtualbox-guest-additions

  # Installing Secure Boot required packages
  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then
    sudo dnf install --assumeyes kmod-VirtualBox
    sudo dnf install --assumeyes VirtualBox-kmodsrc
    sudo dnf install --assumeyes akmod-VirtualBox
  fi
fi
