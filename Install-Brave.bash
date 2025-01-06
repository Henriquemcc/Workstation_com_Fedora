#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing requirements
dnf --assumeyes install dnf-plugins-core

# Installing Brave Browser
if [ "$(command -v dnf4)" ]; then
  dnf4 --assumeyes config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
else
  dnf --assumeyes config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
fi

rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf --assumeyes install brave-browser
