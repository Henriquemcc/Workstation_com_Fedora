#!/bin/bash

sudo dnf install --assumeyes curl
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version