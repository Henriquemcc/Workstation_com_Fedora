#!/bin/bash

bash ./Install-Java_8_Headless.bash

# Checking if Java compiler 8 is installed
if [ "$(command -v javac8)" ]; then
    exit 0
fi

# Installing Java 8 JDK
sudo dnf install --assumeyes java-1.8.0-openjdk-devel

# Creating command javac8
sudo ln --symbolic "/usr/lib/jvm/java-1.8.0/bin/javac" "/bin/javac8"