#!/bin/bash

function sign_virtualbox_kernel_modules() {

  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Installing requirements
    sudo dnf install --assumeyes kmod
    sudo dnf install --assumeyes coreutils
    sudo dnf install --assumeyes kernel-devel
    sudo dnf install --assumeyes akmods

    # Setting private and public key path
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.bash

    # Getting information about VirtualBox module for Linux kernel
    vboxdrv_str="$(modinfo -n vboxdrv)"
    vboxdrv_parent_folder="$(dirname "$vboxdrv_str")"

    # Getting the location of sign-file executable
    uname_str="$(uname -r)"
    sign_file_path="/usr/src/kernels/$uname_str/scripts/sign-file"

    # Signing kernel modules
    for file in "$vboxdrv_parent_folder"/*; do
      echo "$file"
      if [[ "$file" == *.ko ]]; then
        eval "sudo $sign_file_path" sha256 "$path_private_key" "$path_public_key" "$file"
      fi
    done

    # Loading kernel modules
    sudo akmods

    # Restarting VirtualBox service
    sudo systemctl restart vboxdrv.service

  fi
}

# Removing VirtualBox packages from other repositories
sudo dnf autoremove --assumeyes --repoid rpmfusion-free VirtualBox VirtualBox-kmodsrc VirtualBox-server akmod-VirtualBox kmod-VirtualBox

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
sudo /sbin/vboxconfig
sign_virtualbox_kernel_modules