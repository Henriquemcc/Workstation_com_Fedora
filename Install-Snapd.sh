#!/bin/bash

sudo dnf install snapd --assumeyes
sudo ln -s /var/lib/snapd/snap /snap
sudo dnf install fuse --assumeyes
sudo dnf install squashfuse --assumeyes
sudo dnf install kernel-modules --assumeyes