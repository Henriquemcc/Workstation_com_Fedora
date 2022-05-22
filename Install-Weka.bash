#!/bin/bash

# Defining variables
version="3-8-6"
download_file_name="weka-${version}-azul-zulu-linux.zip"
url_weka_zip_file="https://prdownloads.sourceforge.net/weka/${download_file_name}"
path_download_file="/tmp/${download_file_name}"
path_installation_dir="${HOME}/.local/share"
path_weka_dir="${path_installation_dir}/weka-${version}"
path_weka_bin="${path_weka_dir}/weka.sh"
path_weka_icon="${path_weka_dir}/weka.ico"

# Creating directories if they do not exist
sudo mkdir -p "$(dirname "$path_download_file")"
mkdir -p "$path_installation_dir"

# Installing requirements
bash ./Install-Curl.bash
bash ./Install-Unzip.bash

# Downloading Weka
curl -L "$url_weka_zip_file" --output "$path_download_file"

# Unzipping weka
unzip -o "$path_download_file" -d "$path_installation_dir"

# Creating shortcut
path_shortcut="${HOME}/.local/share/applications/Weka.desktop"
 {
    echo "[Desktop Entry]"
    echo "Version=1.5"
    echo "Name=Weka"
    echo "Type=Application"
    echo "Exec=bash $path_weka_bin"
    echo "Icon=$path_weka_icon"
    echo "StartupNotify=true"
    echo "Categories=Education;Science;"
  } > "$path_shortcut"