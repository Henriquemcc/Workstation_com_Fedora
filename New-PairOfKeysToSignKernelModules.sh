#!/bin/bash

# Creating signed modules folder
path_folder_signed_modules="/root/signed-modules"
sudo mkdir -p "$path_folder_signed_modules"

# Creating configuration file
path_configuration_file="$path_folder_signed_modules/configuration_file.config"
{
  echo "[ req ]"
  echo "default_bits = 4096"
  #echo "distinguished_name = req_distinguished_name"
  echo "prompt = no"
  echo "string_mask = utf8only"
  echo "x509_extensions = myexts"
  #echo
  #echo "[ req_distinguished_name ]"
  #echo "O = Organization"
  #echo "CN = Organization signing key"
  #echo "emailAddress = E-mail address"
  echo
  echo "[ myexts ]"
  echo "basicConstraints=critical,CA:FALSE"
  echo "keyUsage=digitalSignature"
  echo "subjectKeyIdentifier=hash"
  echo "authorityKeyIdentifier=keyid"
} | sudo tee "$path_configuration_file"

# Setting key files path
path_private_key="$path_folder_signed_modules/private_key.priv"
path_public_key="$path_folder_signed_modules/public_key.der"

# Creating pair of keys
sudo openssl req -x509 -new -nodes -utf8 -sha256 -days 36500 -batch -config "$path_configuration_file" -outform DER -out "$path_public_key" -keyout "$path_private_key"

# Adding keys to UEFI
sudo mokutil --import "$path_public_key"

# Returning private key file path, public key file path, and folder path
echo "$path_private_key;$path_public_key;$path_folder_signed_modules"
