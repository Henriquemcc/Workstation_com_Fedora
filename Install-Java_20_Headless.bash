#!/bin/bash

# Checking if Java 20 is installed
if [ "$(command -v java20)" ]; then
    exit 0
fi

# Installing Java 20 JRE
sudo dnf install --assumeyes java-latest-openjdk-headless

# Creating command java20
sudo ln --symbolic "/usr/lib/jvm/java-20/bin/java" "/bin/java20"