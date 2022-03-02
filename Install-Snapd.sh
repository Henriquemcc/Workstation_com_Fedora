#!/bin/bash

sudo dnf install --assumeyes snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo dnf install --assumeyes fuse
sudo dnf install --assumeyes squashfuse
sudo dnf install --assumeyes kernel-modules