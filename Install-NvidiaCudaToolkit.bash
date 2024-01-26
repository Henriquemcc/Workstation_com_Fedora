#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

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
