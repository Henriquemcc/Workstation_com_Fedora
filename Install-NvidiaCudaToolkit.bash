#!/bin/bash

# Importing function run_as_root, get_os_type and get_os_version
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Checking if the computer has a NVIDIA GPU
if ! lspci | grep -i nvidia; then
    exit 1
fi

# Checking if architecture is x86_64
if [ "$(uname -m)" != "x86_64" ] ; then
    exit 1
fi

# Installing repository
if [ "$(get_os_type)" == "fedora" ]; then
  dnf config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/$(get_os_type)$(get_os_version)/x86_64/cuda-$(get_os_type)$(get_os_version).repo" || exit 1
elif [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ]; then
  dnf config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/rhel$(get_os_version)/x86_64/cuda-rhel$(get_os_version).repo" || exit 1
fi

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
