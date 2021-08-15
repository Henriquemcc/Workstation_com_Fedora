#!/bin/bash

sudo dnf --assumeyes install https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-1.centos.8.x86_64.rpm || exit 1

sudo pwsh ./InstalarRoot.ps1
pwsh ./InstalarUsuario.ps1
