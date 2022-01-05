#!/bin/bash

# Installing requirements
sudo dnf install git --assumeyes
sudo dnf install git-lfs --assumeyes

# Adding GitHub Cli repository
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo --assumeyes

# Installing GitHub Cli.
sudo dnf install gh --assumeyes