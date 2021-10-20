#!/bin/bash
curl -fsSL https://get.docker.com -o Get-Docker.sh
sudo sh Get-Docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
sudo systemctl enable docker.service docker.socket containerd.service
sudo systemctl start docker.service docker.socket containerd.service