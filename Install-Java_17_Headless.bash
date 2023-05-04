#!/bin/bash

# Checking if Java 17 is installed
if [ "$(command -v java17)" ]; then
    exit 0
fi

# Installing Java 17 JRE
sudo dnf install --assumeyes java-17-openjdk-headless

# Creating command java17
sudo ln --symbolic "/usr/lib/jvm/java-17/bin/java" "/bin/java17"