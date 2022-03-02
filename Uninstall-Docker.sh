#!/bin/bash

# Removing docker packages from the system
sudo dnf remove --assumeyes docker
sudo dnf remove --assumeyes docker-client
sudo dnf remove --assumeyes docker-client-latest
sudo dnf remove --assumeyes docker-common
sudo dnf remove --assumeyes docker-latest
sudo dnf remove --assumeyes docker-latest-logrotate
sudo dnf remove --assumeyes docker-logrotate
sudo dnf remove --assumeyes docker-selinux
sudo dnf remove --assumeyes docker-engine-selinux
sudo dnf remove --assumeyes docker-engine
sudo dnf remove --assumeyes docker-ce
sudo dnf remove --assumeyes docker-ce-cli
sudo dnf remove --assumeyes containerd.io

# Deleting docker files
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Removing docker rootless
dockerd-rootless-setuptool.sh uninstall
/usr/bin/rootlesskit rm -rf ~/.local/share/docker
cd ~/bin || exit
rm -f containerd containerd-shim containerd-shim-runc-v2 ctr docker docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit