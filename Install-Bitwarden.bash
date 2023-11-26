#!/bin/bash

# Installation variables
bitwarden_file_url="https://vault.bitwarden.com/download/?app=desktop&platform=linux"
installation_directory=""
icons_directory=""
shortcut_directory=""
if [ "$(whoami)" == "root" ]; then
  installation_directory="/usr/bin"
  icons_directory="/usr/share/icons/hicolor/64x64/apps"
  shortcut_directory="/usr/share/applications"
else
  installation_directory="${HOME}/.bin"
  icons_directory="${HOME}/.local/share/icons/hicolor/64x64/apps"
  shortcut_directory="${HOME}/.local/share/applications"
fi

# Downloading file
executable_file_name="Bitwarden.AppImage"
mkdir -p "$installation_directory"
executable_file_path="${installation_directory}/${executable_file_name}"
curl -L "$bitwarden_file_url" --output "$executable_file_path"
chmod +x "$executable_file_path"

# Copying icon
icon_file_name="bitwarden.png"
icon_file_source_path="./Resources/Bitwarden/$icon_file_name"
mkdir -p "$icons_directory"
icon_file_destination_path="${icons_directory}/${icon_file_name}"
cp "$icon_file_source_path" "$icon_file_destination_path"

# Creating shortcut
shortcut_file_name="Bitwarden.desktop"
mkdir -p $shortcut_directory
shortcut_file_path="${shortcut_directory}/${shortcut_file_name}"
{
  echo "[Desktop Entry]"
  echo "Version=1.5"
  echo "Type=Application"
  echo "Name=Bitwarden"
  echo "Icon=\"$icon_file_destination_path\""
  echo "Exec=\"$executable_file_path\""
  echo "Terminal=false"
  echo "Keywords=bitwarden; password; manager;"
  echo "Categories=Utility;"
} > "$shortcut_file_path"

