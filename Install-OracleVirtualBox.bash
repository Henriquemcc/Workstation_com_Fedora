#!/bin/bash

# Installing requirements
bash ./Install-GioTrash.bash

function sign_virtualbox_kernel_modules() {

  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Installing requirements
    sudo dnf install --assumeyes kmod
    sudo dnf install --assumeyes coreutils
    sudo dnf install --assumeyes kernel-devel
    sudo dnf install --assumeyes kernel-devel-"$(uname -r)"
    sudo dnf install --assumeyes kernel-headers
    sudo dnf install --assumeyes akmods
    sudo dnf install --assumeyes dkms
    sudo dnf install --assumeyes qt5-qtx11extras
    sudo dnf install --assumeyes elfutils-libelf-devel
    sudo dnf install --assumeyes zlib-devel
    sudo dnf install --assumeyes @development-tools

    bash ./Sign-VirtualBox.bash

    sudo /sbin/vboxconfig

  fi
}

# Removing RPM Fusion's VirtualBox
bash ./Uninstall-VirtualBox.bash

# Downloading and registering Oracle VirtualBox Key
wget https://www.virtualbox.org/download/oracle_vbox.asc
sudo rpm --import ./oracle_vbox.asc
gio trash ./oracle_vbox.asc

# Adding Oracle VirtualBox Repository
wget "https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo"
sudo mv ./virtualbox.repo /etc/yum.repos.d/virtualbox.repo

# Installing VirtualBox
sudo dnf install --refresh --assumeyes VirtualBox-6.1

# Signing VirtualBox Kernel modules
sign_virtualbox_kernel_modules
sudo /sbin/vboxconfig
