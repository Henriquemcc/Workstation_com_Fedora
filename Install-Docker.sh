#!/bin/bash

sudo dnf install --assumeyes shadow-utils
sudo dnf install --assumeyes coreutils
sudo dnf install --assumeyes systemd
sudo dnf install --assumeyes fuse-overlayfs
sudo dnf install --assumeyes iptables

curl -fsSL https://get.docker.com -o get-docker.sh
DRY_RUN=1 sh ./get-docker.sh

sudo dnf install --assumeyes docker-compose