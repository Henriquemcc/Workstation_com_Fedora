#!/bin/bash

# Installing VirtualBox
sudo dnf install --assumeyes virtualbox

# Siging VirtualBox Kernel Modules
sudo pwsh ./Install-VirtualBoxSignedKernelModules.ps1