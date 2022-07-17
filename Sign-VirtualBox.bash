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

function sign_virtualbox_modules() {
  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Clean module files before signing; For debug only
    #sudo dnf remove --assumeyes VirtualBox-kmodsrc VirtualBox-server akmod-VirtualBox kernel-devel-$(uname -r) kmod-VirtualBox virtualbox-guest-additions VirtualBox
    #sudo dnf remove --assumeyes kmod-VirtualBox-6.1.34-3.fc36.x86_64
    #sudo dnf install --assumeyes VirtualBox-kmodsrc VirtualBox-server akmod-VirtualBox kernel-devel-$(uname -r) kmod-VirtualBox virtualbox-guest-additions VirtualBox kmod-VirtualBox-6.1.34-3.fc36.x86_64
    #sudo dnf install --assumeyes kmod-VirtualBox-6.1.34-3.fc36.x86_64
    #sudo dnf reinstall --assumeyes kmod-VirtualBox-6.1.34-3.fc36.x86_64

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.bash

    # Setting private and public key path
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"
    #echo "DEBUG1: \$path_folder_signed_modules = $path_folder_signed_modules"
    #echo "DEBUG2: \$path_private_key = $path_private_key"
    #echo "DEBUG3: \$path_public_key = $path_public_key"

    sign_file_binary_path="/usr/src/kernels/$(uname -r)/scripts/sign-file"
    #echo "DEBUG4: \$sign_file_binary_path = $sign_file_binary_path"

    path_virtualbox_modules_directory="$(dirname "$(modinfo -n vboxdrv)")"
    #echo "DEBUG5: \$path_virtualbox_modules_directory = $path_virtualbox_modules_directory"

    # For each file in the VirtualBox kernel module directory
    for file_path_in_virtualbox_modules_directory in "$path_virtualbox_modules_directory"/*; do

      # Decompressing XZ file
      if [ "${file_path_in_virtualbox_modules_directory: -3}" == ".xz" ]; then
        command_to_sign_kernel_module="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$file_path_in_virtualbox_modules_directory\""
        #echo "DEBUG7: \$command_to_sign_kernel_module = $command_to_sign_kernel_module"
        eval "$command_to_sign_kernel_module"
        xz --decompress --keep "$file_path_in_virtualbox_modules_directory"
        file_path_in_virtualbox_modules_directory="${file_path_in_virtualbox_modules_directory::-3}"
        #echo "DEBUG6: \$file_path_in_virtualbox_modules_directory = $file_path_in_virtualbox_modules_directory"
      fi

      # Signing .ko file
      if [ "${file_path_in_virtualbox_modules_directory: -3}" == ".ko" ]; then
        command_to_sign_kernel_module="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$file_path_in_virtualbox_modules_directory\""
        #echo "DEBUG7: \$command_to_sign_kernel_module = $command_to_sign_kernel_module"
        eval "$command_to_sign_kernel_module"
      fi

    done

  fi

}

# Running as root
run_as_root

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

sign_virtualbox_modules

# Loading VirtualBox kernel modules
sudo modprobe vboxdrv

# Rebuilding kernel akmod packages
sudo akmods

# Restarting VirtualBox service
sudo systemctl restart vboxdrv.service

# Configuring VirtualBox
sudo /sbin/vboxconfig
