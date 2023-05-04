#!/bin/bash

bash ./Install-Java_11_Headless.bash

# Checking if Java compiler 11 is installed
if [ "$(command -v javac11)" ]; then
    exit 0
fi

# Installing Java 11 JDK
sudo dnf install --assumeyes java-11-openjdk-devel

# Creating command javac11
sudo ln --symbolic "/usr/lib/jvm/java-11/bin/javac" "/bin/javac11"