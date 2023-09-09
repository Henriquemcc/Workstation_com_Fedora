#!/bin/bash

bash ./Install-Java_21_Headless.bash

# Installing Java 21 JRE and JDK
sudo dnf install --assumeyes java-latest-openjdk

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 21"
  echo "GenericName=Java 21"
  echo "Icon=java-21-openjdk"
  echo "Exec=java21 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 21; jre"
  echo "StartupNotify=true"
} | sudo tee "/usr/share/applications/java21.desktop"
