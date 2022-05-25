#!/bin/bash

# Installing library Python.h
if ! dnf list --installed python3-devel > /dev/null; then
  sudo dnf install --assumeyes python3-devel
fi

# Installing Python Pip
if ! [ "$(command -v pip)" ]; then
  sudo dnf install --assumeyes python3-pip
fi

# Installing orange
if ! [ "$(command -v orange-canvas)" ]; then
  sudo pip install orange3
fi

# Getting orange installation dir
path_orange_installation_dir="$(pip show orange3 | grep "Location: ")"
path_orange_installation_dir="${path_orange_installation_dir/Location: /""}"
path_orange_installation_dir="${path_orange_installation_dir}/Orange"

# Getting orange icon
path_orange_icon="${path_orange_installation_dir}/canvas/icons/orange-canvas.svg"

# Creating shortcut
path_shortcut="${HOME}/.local/share/applications/Orange.desktop"
{
  echo "[Desktop Entry]"
  echo "Version=1.5"
  echo "Name=Orange"
  echo "Type=Application"
  echo "Exec=orange-canvas"
  echo "Icon=$path_orange_icon"
  echo "StartupNotify=true"
  echo "Categories=Education;Science;"
} >"$path_shortcut"
