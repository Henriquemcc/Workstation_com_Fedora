#!/bin/bash

# Adding repository
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora37/x86_64/cuda-fedora37.repo

# Installing Nvidia Cuda
sudo dnf module install --refresh --assumeyes nvidia-driver:latest-dkms
sudo dnf install --assumeyes cuda