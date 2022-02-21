#!/bin/bash

# Installing requirements
sudo dnf install --assumeyes curl

# Installing RustLang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init.sh
sh ./rustup-init.sh --quiet --component cargo rustc rustup --profile complete -y

# Running RustLang environment
source $HOME/.cargo/env
