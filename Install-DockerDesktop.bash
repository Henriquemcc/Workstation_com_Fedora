#!/bin/bash

# Installing requirements
sudo dnf install dnf-plugins-core --assumeyes

# Adding Docker repository
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo --assumeyes

# Installing Docker desktop
sudo dnf install https://desktop.docker.com/linux/main/amd64/docker-desktop-4.8.1-x86_64.rpm docker-ce docker-ce-cli containerd.io docker-compose-plugin --assumeyes
