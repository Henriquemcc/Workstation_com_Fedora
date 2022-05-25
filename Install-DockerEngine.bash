#!/bin/bash

# Downloading convenience script
curl -fsSL https://get.docker.com -o get-docker.sh

# Running convenience script
sudo sh get-docker.sh

# Installing docker rootless
dockerd-rootless-setuptool.sh install

# Enabling docker service
sudo systemctl enable docker.service

# Removing convenience script
bash ./Install-GioTrash.bash
gio trash ./get-docker.sh