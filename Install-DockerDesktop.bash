#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Docker Engine
bash ./Install-DockerEngine.bash

# Installing Docker desktop
dnf install --assumeyes https://desktop.docker.com/linux/main/amd64/docker-desktop-4.26.1-x86_64.rpm
