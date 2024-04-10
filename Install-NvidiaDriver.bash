#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Importing function run_as_root, get_os_type and get_os_version
source RunAsRoot.bash
source OsInfo.bash

# Checking if the computer has a NVIDIA GPU
if ! lspci | grep -i nvidia; then
    exit 0
fi

# Checking if architecture is x86_64
if [ "$(uname -m)" != "x86_64" ] ; then
    exit 0
fi

# Installing repository
if [ "$(get_os_type)" == "fedora" ]; then
  dnf config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/$(get_os_type)$(get_os_version)/x86_64/cuda-$(get_os_type)$(get_os_version).repo" || exit 1
elif [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ]; then
  dnf config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/rhel$(get_os_version)/x86_64/cuda-rhel$(get_os_version).repo" || exit 1
fi


# Removing conflicting packages
dnf autoremove --assumeyes xorg-x11-drv-nvidia-cuda-libs
dnf autoremove --assumeyes xorg-x11-drv-nvidia-power
dnf autoremove --assumeyes xorg-x11-drv-nvidia-cuda

# Installing Nvidia driver
dnf module install --assumeyes nvidia-driver