#!/bin/bash

# Checking if the computer has a NVIDIA GPU
if ! lspci | grep -i nvidia; then
    exit 0
fi

# Checking if architecture is x86_64
if [ "$(uname -m)" != "x86_64" ] ; then
    exit 0
fi

# Removing conflicting packages
sudo dnf autoremove --assumeyes xorg-x11-drv-nvidia-cuda-libs
sudo dnf autoremove --assumeyes xorg-x11-drv-nvidia-power
sudo dnf autoremove --assumeyes xorg-x11-drv-nvidia-cuda

# Installing repository
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora35/x86_64/cuda-fedora35.repo

# Installing Nvidia driver
sudo dnf module install --assumeyes nvidia-driver