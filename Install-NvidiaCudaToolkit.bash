#!/bin/bash

# Adding repository
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora37/x86_64/cuda-fedora37.repo

# Removing conflicting packages
sudo dnf --assumeyes remove egl-gbm
sudo dnf --assumeyes remove xorg-x11-drv-nvidia-cuda-libs

# Installing Nvidia Cuda
sudo dnf module install --allowerasing --refresh --assumeyes nvidia-driver:open-dkms
sudo dnf --assumeyes --disablerepo="rpmfusion-nonfree*" install cuda

# Updating grub
sudo grub2-mkconfig -o /etc/grub2.cfg
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
