#!/bin/bash

bash ./Install-Java_11_Headless.bash

# Installing Java 11 JRE and JDK
sudo dnf install --assumeyes java-11-openjdk

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
