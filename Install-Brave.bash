#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing requirements
dnf --assumeyes install dnf-plugins-core

# Installing Brave Browser
dnf --assumeyes config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf --assumeyes install brave-browser
