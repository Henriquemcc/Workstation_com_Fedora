#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root()
{
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

function sign_virtualbox_modules()
{
  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.bash

    # Setting private and public key path
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"
    echo "DEBUG: \$path_folder_signed_modules = $path_folder_signed_modules"
    echo "DEBUG: \$path_private_key = $path_private_key"
    echo "DEBUG: \$path_public_key = $path_public_key"

    sign_file_binary_path="/usr/src/kernels/$(uname -r)/scripts/sign-file"
    echo "DEBUG: \$sign_file_binary_path = $sign_file_binary_path"

    declare -a module_names
    module_names+=("vboxdrv")
    module_names+=("vboxnetflt")
    module_names+=("vboxnetadp")
    module_names+=("vboxpci")

    for module_name in "${module_names[@]}"; do
      module_file_path="$(modinfo -n "$module_name")"
      echo "DEBUG: \$module_file_path = $module_file_path"

      if [ -f "$module_file_name" ]; then
        module_directory="$(dirname "$module_file_path")"
        echo "DEBUG: \$module_directory = $module_directory"

        if [ -d "$module_directory" ]; then
    for module_file_name in "$module_directory"/*; do
      echo "DEBUG: \$module_file_name = $module_file_name"
      if [ -f "$module_file_name" ] && [ "$module_file_name" == "*.ko" ]; then
        command_to_sign_kernel_module="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$module_file_name\""
        echo "DEBUG: \$command_to_sign_kernel_module = $command_to_sign_kernel_module"
        eval "$command_to_sign_kernel_module"
      fi
    done
        fi
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
