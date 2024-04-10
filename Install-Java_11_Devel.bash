#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_11_Headless.bash

# Checking if Java compiler 11 is installed
if [ "$(command -v javac11)" ]; then
    exit 0
fi

# Installing Java 11 JDK
dnf install --assumeyes java-11-openjdk-devel

# Creating command javac11
ln --symbolic "/usr/lib/jvm/java-11/bin/javac" "/bin/javac11"