#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Google Earth
dnf install --assumeyes https://dl.google.com/dl/earth/client/current/google-earth-pro-stable-current.x86_64.rpm