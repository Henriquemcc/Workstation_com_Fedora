#!/bin/bash
sudo dnf upgrade --refresh --assumeyes
sudo snap refresh
sudo flatpak update --assumeyes
flatpak update --assumeyes