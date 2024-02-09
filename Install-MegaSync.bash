#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installation variables
VERSION_ID="$(awk -F= '$1=="VERSION_ID" { print $2 ;}' /etc/os-release)"
ARCHITECTURE="$(uname -m)"

# Installing Mega Sync
dnf install --assumeyes "https://mega.nz/linux/repo/Fedora_${VERSION_ID}/${ARCHITECTURE}/megasync-Fedora_${VERSION_ID}.${ARCHITECTURE}.rpm"