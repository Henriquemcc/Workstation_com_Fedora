#!/bin/bash

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm --assumeyes
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm --assumeyes
sudo dnf install rpmfusion-free-release-tainted --assumeyes
sudo dnf install rpmfusion-nonfree-release-tainted --assumeyes