#!/bin/bash

# Checking if Java 8 is installed
if [ "$(command -v java8)" ]; then
    exit 0
fi

# Installing Java 8 JRE
sudo dnf install --assumeyes java-1.8.0-openjdk-headless

# Creating command java8
sudo ln --symbolic "/usr/lib/jvm/java-1.8.0/bin/java" "/bin/java8"