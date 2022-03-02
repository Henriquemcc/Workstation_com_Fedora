#!/bin/bash

# Installing requirements
sudo dnf install --assumeyes shadow-utils
sudo dnf install --assumeyes coreutils
sudo dnf install --assumeyes systemd
sudo dnf install --assumeyes fuse-overlayfs
sudo dnf install --assumeyes iptables

# Installing docker
if ! [ "$(command -v docker)" ] || ! [ "$(command -v containerd)" ]; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  bash ./get-docker.sh
fi

# Installing docker rootless
bash dockerd-rootless-setuptool.sh install

# Adding string to bashrc file
bashrc_file="${HOME}/.bashrc"
string_to_bashrc="export PATH=/usr/bin:\$PATH"
if ! grep -q "$string_to_bashrc" "$bashrc_file"; then
  echo "$string_to_bashrc" >>"$bashrc_file"
fi

# Adding string to bashrc file
string_to_bashrc="export DOCKER_HOST=unix:///run/user/1000/docker.sock"
if ! grep -q "$string_to_bashrc" "$bashrc_file"; then
  echo "$string_to_bashrc" >>"$bashrc_file"
fi

# Installing docker compose
if ! [ "$(command -v docker-compose)" ]; then
  sudo dnf install --assumeyes docker-compose
fi
