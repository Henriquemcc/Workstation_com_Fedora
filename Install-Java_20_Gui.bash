#!/bin/bash

bash ./Install-Java_20_Headless.bash

# Installing Java 20 JRE and JDK
sudo dnf install --assumeyes java-latest-openjdk

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 20"
  echo "GenericName=Java 20"
  echo "Icon=java-20-openjdk"
  echo "Exec=java20 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 20; jre"
  echo "StartupNotify=true"
} | sudo tee "/usr/share/applications/java20.desktop"
