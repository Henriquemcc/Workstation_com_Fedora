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

# Running as root
run_as_root

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

  declare -a module_names
  module_names+=("vboxdrv")
  module_names+=("vboxnetflt")
  module_names+=("vboxnetadp")
  module_names+=("vboxpci")

  for module_name in "${module_names[@]}"; do
    module_file_path="$(modinfo -n "$module_name")"
    module_directory="$(dirname "$module_file_path")"

    for file_name in "$module_directory"/*; do
      if [ -f "$file_name" ] && [ "$file_name" == "*.ko" ]; then
        eval "$sign_file_binary_path" sha256 "$path_private_key" "$path_public_key" "$file_name"
      fi
    done
  done
fi
