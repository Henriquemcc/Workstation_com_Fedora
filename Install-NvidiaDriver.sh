#!/bin/bash

# Enabling RPM Fusion
if [ "$(dnf repolist --repoid rpmfusion-nonfree | sed -n 2p)" != "Error: Unknown repo: 'rpmfusion-nonfree'" ]; then
    bash Enable-RpmFusion.sh
fi

# Installing Nvidia
sudo dnf install akmod-nvidia --assumeyes
sudo dnf install xorg-x11-drv-nvidia-cuda --assumeyes