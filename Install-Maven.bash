#!/bin/bash

# Installing requirements
## Gio command
if ! [ "$(command -v gio)" ]; then
    bash ./Install-Glib.bash
fi

# Downloading Maven
url="https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz"
apache_maven_file="/tmp/apache-maven-bin.tar.gz"
curl -L $url --output "$apache_maven_file"

# Checking if share folder exists
local_share_dir="$HOME/.local/share"
if ! [ -d "$local_share_dir" ]; then
    mkdir -p "$local_share_dir"
fi

# Deleting old installation folders
maven_install_dir="$local_share_dir/apache-maven-*"
if [ -d "$maven_install_dir" ]; then
    gio trash "$maven_install_dir"
fi

# Extracting Maven
tar -xzvf "$apache_maven_file" --overwrite -C "$local_share_dir"

# Creating symbolic links
symbolic_links_dir="$HOME/.bin"
symbolic_links=("mvn" "mvnDebug" "mvnyjp")

for symbolic_link in "${symbolic_links[@]}" ; do

    ## Deleting old symbolic links
    if [ -h "${symbolic_links_dir}/${symbolic_link}" ] || [ -f "${symbolic_links_dir}/${symbolic_link}" ] ; then
        gio trash "${symbolic_links_dir}/${symbolic_link}"
    fi

    ## Creating the new symbolic links
    target="${maven_install_dir}/bin/${symbolic_link}"
    target=$(eval "ls $target")
    ln --symbolic "$target" "${symbolic_links_dir}/${symbolic_link}"

done
