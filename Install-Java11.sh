#!/bin/bash

# Checking if Java 11 is installed
if [ "$(command -v java11)" ] && [ "$(command -v javac11)" ]; then
    exit 0
fi

# Installing Java 11 JRE and JDK
sudo dnf install --assumeyes java-11-openjdk
sudo dnf install --assumeyes java-11-openjdk-devel

# Creating command java11 and javac11
sudo ln --symbolic "/usr/lib/jvm/java-11/bin/java" "/bin/java11"
sudo ln --symbolic "/usr/lib/jvm/java-11/bin/javac" "/bin/javac11"

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 11"
  echo "GenericName=Java 11"
  echo "Icon=java-11-openjdk"
  echo "Exec=java11 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 11; jre"
  echo "StartupNotify=true"
} | sudo tee "/usr/share/applications/java11.desktop"



