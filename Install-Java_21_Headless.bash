#!/bin/bash

# Checking if Java 21 is installed
if [ "$(command -v java21)" ]; then
    exit 0
fi

# Installing Java 21 JRE
sudo dnf install --assumeyes java-latest-openjdk-headless

# Creating command java21
sudo ln --symbolic "/usr/lib/jvm/java-21/bin/java" "/bin/java21"
