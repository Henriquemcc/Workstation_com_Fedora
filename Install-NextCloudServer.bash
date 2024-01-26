#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing requirements
bash ./Install-Snapd.bash

# Installing NextCloud
snap install nextcloud