#!/bin/bash

if ! [ "$(command -v curl)" ]; then
    sudo dnf install --assumeyes curl
fi