#!/bin/bash

bash ./Install-Java_17_Headless.bash

# Checking if Java compiler 17 is installed
if [ "$(command -v javac17)" ]; then
    exit 0
fi

# Installing Java 17 JDK
sudo dnf install --assumeyes java-17-openjdk-devel

# Creating command javac17
sudo ln --symbolic "/usr/lib/jvm/java-17/bin/javac" "/bin/javac17"