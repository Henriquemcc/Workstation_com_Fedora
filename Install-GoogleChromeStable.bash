#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Google Chrome Stable
dnf install --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm