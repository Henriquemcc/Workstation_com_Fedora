#!/bin/bash

# Installing requirements
bash ./Install-Flatpak.sh

# Adding Flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo