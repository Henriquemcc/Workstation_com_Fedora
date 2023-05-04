#!/bin/bash

bash ./Install-Java_20_Headless.bash

# Checking if Java compiler 20 is installed
if [ "$(command -v javac20)" ]; then
    exit 0
fi

# Installing Java 20 JDK
sudo dnf install --assumeyes java-latest-openjdk-devel

# Creating command javac20
sudo ln --symbolic "/usr/lib/jvm/java-20/bin/javac" "/bin/javac20"