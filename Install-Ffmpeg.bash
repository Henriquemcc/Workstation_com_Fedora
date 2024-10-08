#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Habilitando repositório Code Ready Builder
if [ "$(get_os_type)" == "ol" ]; then
    dnf config-manager --enable ol9_codeready_builder
fi

# Instalando ffmpeg
dnf install --allowerasing --assumeyes ffmpeg