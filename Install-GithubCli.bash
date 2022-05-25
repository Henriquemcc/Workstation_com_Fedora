#!/bin/bash

# Installing requirements
sudo dnf install  --assumeyes 'dnf-command(config-manager)'
sudo dnf install --assumeyes git
sudo dnf install --assumeyes git-lfs

# Adding GitHub Cli repository
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo --assumeyes

# Installing GitHub Cli.
sudo dnf install --assumeyes gh