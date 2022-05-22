#!/bin/bash

if ! [ "$(command -v speedtest)" ]; then
  curl -s https://install.speedtest.net/app/cli/install.rpm.sh | sudo bash
  sudo dnf --assumeyes install speedtest
fi