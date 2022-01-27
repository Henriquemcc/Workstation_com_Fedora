#!/bin/bash

if ! [ "$(command -v java)" ]; then
    sudo dnf install --assumeyes java-1.8.0-openjdk.x86_64
fi