#!/bin/bash

# Checking if Java 8 is installed
if [ "$(command -v java8)" ] && [ "$(command -v javac8)" ]; then
    exit 0
fi

# Installing Java 8 JRE and JDK
sudo dnf install --assumeyes java-1.8.0-openjdk
sudo dnf install --assumeyes java-1.8.0-openjdk-devel

# Creating command java8 and javac8
sudo ln --symbolic "/usr/lib/jvm/java-1.8.0/bin/java" "/bin/java8"
sudo ln --symbolic "/usr/lib/jvm/java-1.8.0/bin/javac" "/bin/javac8"

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 8"
  echo "GenericName=Java 8"
  echo "Icon=java-1.8.0-openjdk"
  echo "Exec=java8 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 8; jre"
  echo "StartupNotify=true"
} | sudo tee "/usr/share/applications/java8.desktop"
