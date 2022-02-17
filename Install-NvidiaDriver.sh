#!/bin/bash

function sign_nvidia_kernel_modules() {

  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Installing requirements
    sudo dnf install --assumeyes kmod
    sudo dnf install --assumeyes coreutils

    # Setting private and public key path
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.sh

    # Getting information about Nvidia module for Linux kernel
    nvidia="$(sudo modinfo -n nvidia)"
    nvidia_parent_folder="$(dirname "$nvidia")"

    # Getting the location of sign-file executable
    uname_str="$(uname -r)"
    sign_file_path="/usr/src/kernels/$uname_str/scripts/sign-file"

    # Signing kernel modules
    for file in "$nvidia_parent_folder"/* ; do
      if [[ "$file" == *.ko ]]; then
        eval "sudo $sign_file_path" sha256 "$path_private_key" "$path_public_key" "$file"
      fi
    done
  fi
}

# Enabling RPM Fusion
bash ./Enable-RpmFusion.sh

# Installing Nvidia
sudo dnf install --assumeyes akmod-nvidia
sudo dnf install --assumeyes xorg-x11-drv-nvidia-cuda
sudo dnf install --assumeyes xrandr

# Signing kernel modules
sign_nvidia_kernel_modules