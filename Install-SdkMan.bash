#!/bin/bash

if ! [ "$(command -v sdk)" ]; then
  sudo dnf install --assumeyes curl
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk version
fi