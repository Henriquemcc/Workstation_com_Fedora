#!/bin/bash

if ! [ "$(command -v xrandr)" ]; then
    sudo dnf install --assumeyes xrandr
fi