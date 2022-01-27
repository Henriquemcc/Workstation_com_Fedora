#!/bin/bash

if ! [ "$(command -v java)" ]; then
    sudo dnf install --assumeyes java-1.8.0-openjdk
    sudo dnf install --assumeyes sudo dnf install java-1.8.0-openjdk-devel
fi