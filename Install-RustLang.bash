#!/bin/bash

# Checking if RustLang is already installed
if [ "$(command -v cargo)" ] && [ "$(command -v rustc)" ] && [ "$(command -v rustup )" ]; then
    exit 0
fi

# Installing requirements
bash ./Install-Curl.bash

# Installing RustLang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init.sh
sh ./rustup-init.sh --quiet --component cargo rustc rustup --profile complete -y

# Running RustLang environment
source $HOME/.cargo/env

# Moving to trash downloaded Rust script
gio trash ./rustup-init.sh