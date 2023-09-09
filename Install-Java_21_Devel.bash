#!/bin/bash

bash ./Install-Java_21_Headless.bash

# Checking if Java compiler 21 is installed
if [ "$(command -v javac21)" ]; then
    exit 0
fi

# Installing Java 21 JDK
sudo dnf install --assumeyes java-latest-openjdk-devel

# Creating command javac20
sudo ln --symbolic "/usr/lib/jvm/java-21/bin/javac" "/bin/javac21"
