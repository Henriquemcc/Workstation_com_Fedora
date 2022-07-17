#!/bin/bash

# Uninstalling Oracle VirtualBox
bash ./Uninstall-OracleVirtualBox.bash

# Enabling RPM fusion
bash ./Enable-RpmFusion.bash

# Installing VirtualBox
if ! [ "$(command -v virtualbox)" ]; then
  sudo dnf install --assumeyes VirtualBox
  sudo dnf install --assumeyes virtualbox-guest-additions
fi
