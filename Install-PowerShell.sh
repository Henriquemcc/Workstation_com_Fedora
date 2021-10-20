#!/bin/bash

function InstallPowerShell_On_Fedora_x86_64
{
  sudo dnf --assumeyes install https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/powershell-7.1.5-1.centos.8.x86_64.rpm
}

function InstallPowerShell_On_Fedora_aarch64
{
  wget --no-clobber https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/powershell-7.1.5-linux-arm64.tar.gz
  sudo mkdir /usr/share/powershell
  sudo tar -xvf ./powershell-7.1.5-linux-arm64.tar.gz --directory /usr/share/powershell/
  sudo ln --symbolic /usr/share/powershell/pwsh /bin/pwsh
  sudo chmod 777 /bin/pwsh
}

if [ $(arch) == "x86_64" ]; then
  InstallPowerShell_On_Fedora_x86_64
elif [ $(arch) == "aarch64" ]; then
  InstallPowerShell_On_Fedora_aarch64
fi