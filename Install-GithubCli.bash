#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing requirements
dnf install  --assumeyes 'dnf-command(config-manager)'
dnf install --assumeyes git
dnf install --assumeyes git-lfs

# Adding GitHub Cli repository
dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo --assumeyes

# Installing GitHub Cli.
dnf install --assumeyes gh