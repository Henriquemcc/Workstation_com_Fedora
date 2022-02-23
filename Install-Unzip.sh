#!/bin/bash

if ! [ "$(command -v unzip)" ]; then
    sudo dnf install --assumeyes unzip
fi