#!/bin/bash

function sign_virtualbox_kernel_modules() {

  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Installing requirements
    sudo dnf install --assumeyes kmod
    sudo dnf install --assumeyes coreutils
    sudo dnf install --assumeyes akmod-VirtualBox
    sudo dnf install --assumeyes kernel-devel
    sudo dnf install --assumeyes kernel-devel-"$(uname -r)"
    sudo dnf install --assumeyes kernel-headers
    sudo dnf install --assumeyes akmods
    sudo dnf install --assumeyes kmod-VirtualBox
    sudo dnf install --assumeyes dkms
    sudo dnf install --assumeyes qt5-qtx11extras
    sudo dnf install --assumeyes elfutils-libelf-devel
    sudo dnf install --assumeyes zlib-devel
    sudo dnf install --assumeyes @development-tools

    bash ./Sign-VirtualBox.bash

  fi
}

# Uninstalling Oracle VirtualBox
bash ./Uninstall-OracleVirtualBox.bash

# Installing VirtualBox
if ! [ "$(command -v virtualbox)" ]; then
  sudo dnf install --assumeyes VirtualBox
  sudo dnf install --assumeyes virtualbox-guest-additions
fi

# Singing kernel modules
sign_virtualbox_kernel_modules

# Loading VirtualBox kernel modules
sudo modprobe vboxdrv

# Rebuilding kernel akmod packages
sudo akmods

# Restarting VirtualBox service
sudo systemctl restart vboxdrv.service