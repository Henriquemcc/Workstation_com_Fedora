#!/bin/bash

# Installing requirements
sudo dnf install --assumeyes curl

# Installing RustLang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Running RustLang environment
source $HOME/.cargo/env