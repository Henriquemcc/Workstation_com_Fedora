#!/bin/bash

bash ./Uninstall-Docker.sh
bash ./Install-Docker.sh

# Stopping services
sudo systemctl stop docker.socket
sudo systemctl stop docker.service
sudo systemctl stop containerd.service

# Stopping user services
systemctl stop --user docker.socket
systemctl stop --user docker.service
systemctl stop --user containerd.service

# Enabling services
sudo systemctl enable docker.socket
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Starting services
sudo systemctl start docker.socket
sudo systemctl start docker.service
sudo systemctl start containerd.service