#!/bin/bash

# Defining path signed modules folder and
path_folder_signed_modules="/root/signed-modules"
path_private_key="$path_folder_signed_modules/private_key.priv"

# Creating pair of key if they do not exist
if ! [ -f $path_private_key ]; then
    bash ./New-KernelModulesPairOfKeys.sh
fi

# Returning private key
sudo cat "$path_private_key"
