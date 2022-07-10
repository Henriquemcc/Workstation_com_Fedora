#!/bin/bash

function sign_virtualbox_kernel_modules() {

  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Installing requirements
    sudo dnf install --assumeyes kmod
    sudo dnf install --assumeyes coreutils
    sudo dnf install --assumeyes akmod-VirtualBox
    sudo dnf install --assumeyes kernel-devel
    sudo dnf install --assumeyes kernel-devel-"$(uname -r)"
    sudo dnf install --assumeyes akmods
    sudo dnf install --assumeyes kmod-VirtualBox

    # Setting private and public key path
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.bash

    # VirtualBox module names
    declare -a module_names
    module_names+=("vboxdrv")
    module_names+=("vboxnetflt")
    module_names+=("vboxnetadp")
    module_names+=("vboxpci")

    for module_name in "${module_names[@]}"; do

      # Getting information about VirtualBox module for Linux kernel
      module_file_name="$(modinfo -n "$module_name")"
      module_file_parent_folder="$(dirname "$module_file_name")"

      # Getting the location of sign-file executable
      sign_file_path="/usr/src/kernels/$(uname -r)/scripts/sign-file"

      # Signing kernel modules
      for file in "$module_file_parent_folder"/*; do
        if [[ "$file" == *.xz ]]; then
          xz --decompress "$file"
          file=${file::3}
        fi
        if [[ "$file" == *.ko ]]; then
          eval "sudo $sign_file_path" sha256 "$path_private_key" "$path_public_key" "$file"
        fi
      done
    done

    # Loading kernel modules
    sudo akmods

    # Restarting VirtualBox service
    sudo systemctl restart vboxdrv.service

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
