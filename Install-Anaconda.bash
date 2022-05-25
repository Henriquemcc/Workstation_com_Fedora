#!/bin/bash

if [ "$(command -v anaconda)" ]; then
   exit 0;
fi

# Trying to install using dnf package manager
{
  sudo dnf install --assumeyes anaconda


# Installing using anaconda script
} || {

# Installing requirements
sudo dnf install --assumeyes wget
sudo dnf install --assumeyes glib2
sudo dnf install --assumeyes libXcomposite
sudo dnf install --assumeyes libXcursor
sudo dnf install --assumeyes libXi
sudo dnf install --assumeyes libXtst
sudo dnf install --assumeyes libXrandr
sudo dnf install --assumeyes alsa-lib
sudo dnf install --assumeyes mesa-libEGL
sudo dnf install --assumeyes libXdamage
sudo dnf install --assumeyes mesa-libGL
sudo dnf install --assumeyes libXScrnSaver

# Setting package variable
architecture=""
if [ "$(uname -m)" == "x86_64" ]; then # x86_64
  architecture="x86_64"
elif [ "$(uname -m)" == "aarch64" ] || [ "$(uname -m)" == "arm64" ]; then # ARM64
  architecture="aarch64"
elif [ "$(uname -m)" == "ppc64le" ]; then # Power PC 64 Little-Endian
  architecture="ppc64le"
fi
version="3-2022.05"
file_name="Anaconda${version}-Linux-${architecture}.sh"
url="https://repo.anaconda.com/archive/${file_name}"
file_path="$(pwd)/${file_name}"

# Downloading Script
wget "$url"

# Running script
bash "$file_path" -b

# Moving to trash downloaded script
gio trash "$file_path"

}