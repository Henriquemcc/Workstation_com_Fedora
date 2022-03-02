#!/bin/bash

# Installing requirements
sudo dnf install --assumeyes curl

# Downloading Microsoft Teams
curl -L "https://go.microsoft.com/fwlink/p/?LinkID=2112907&clcid=0x409" --output "./teams.rpm"

# Installing Microsoft Teams
sudo dnf install --assumeyes ./teams.rpm