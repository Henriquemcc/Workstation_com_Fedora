#!/bin/bash

if ! [ "$(command -v gio)" ]; then
    sudo dnf install --assumeyes glib2
fi