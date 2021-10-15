#!/bin/bash

# Tentando executar o script do PowerShell
pwsh ./Main.ps1

# Caso tenha ocorrido erro, tentando instalar o PowerShell para depois executar o script
if [ $? -eq 127 ]; then
  sudo dnf --assumeyes install https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/powershell-7.1.5-1.centos.8.x86_64.rpm
  pwsh ./Main.ps1
fi
