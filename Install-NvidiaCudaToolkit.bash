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

# Adding repository
dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora37/x86_64/cuda-fedora37.repo

# Removing conflicting packages
dnf --assumeyes remove egl-gbm
dnf --assumeyes remove xorg-x11-drv-nvidia-cuda-libs

# Installing Nvidia Cuda
dnf module install --allowerasing --refresh --assumeyes nvidia-driver:open-dkms
dnf --assumeyes --disablerepo="rpmfusion-nonfree*" install cuda

# Updating grub
grub2-mkconfig -o /etc/grub2.cfg
grub2-mkconfig -o /etc/grub2-efi.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg
