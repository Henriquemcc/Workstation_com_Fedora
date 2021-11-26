#!/bin/bash

sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo --assumeyes
sudo dnf install gh --assumeyes