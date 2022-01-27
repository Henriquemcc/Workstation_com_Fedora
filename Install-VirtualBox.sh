#!/bin/bash

# Installing VirtualBox
sudo dnf install --assumeyes virtualbox

# Installing requirements
bash ./Install-PowerShell.sh

# Siging VirtualBox Kernel Modules
sudo pwsh ./Install-VirtualBoxSignedKernelModules.ps1