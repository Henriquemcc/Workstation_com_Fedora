#!/bin/bash

# Installing Java 17 JRE and JDK
sudo dnf install --assumeyes java-17-openjdk
sudo dnf install --assumeyes java-17-openjdk-devel

# Creating command java17 and javac17
sudo ln --symbolic "/usr/lib/jvm/java-17/bin/java" "/bin/java17"
sudo ln --symbolic "/usr/lib/jvm/java-17/bin/javac" "/bin/javac17"

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 17"
  echo "GenericName=Java 17"
  echo "Icon=java-17-openjdk"
  echo "Exec=java17 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 17; jre"
  echo "StartupNotify=true"
} | sudo tee "/usr/share/applications/java17.desktop"



