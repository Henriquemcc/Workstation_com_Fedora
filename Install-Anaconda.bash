#!/bin/bash

if ! [ "$(command -v anaconda)" ]; then
  sudo dnf install --assumeyes anaconda
fi