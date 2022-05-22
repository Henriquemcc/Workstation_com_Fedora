#!/bin/bash

if ! [ "$(command -v tar)" ]; then
    sudo dnf install --assumeyes tar
fi