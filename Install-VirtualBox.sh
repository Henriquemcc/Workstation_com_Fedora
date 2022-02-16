#!/bin/bash

function sign_virtualbox_kernel_modules() {

  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Installing requirements
    sudo dnf install --assumeyes kmod
    sudo dnf install --assumeyes coreutils
    sudo dnf install --assumeyes akmod-VirtualBox
    sudo dnf install --assumeyes kernel-devel
    sudo dnf install --assumeyes akmods

    # Setting private and public key path
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.sh

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

# Installing VirtualBox
sudo dnf install --assumeyes VirtualBox

# Singing kernel modules
sign_virtualbox_kernel_modules
