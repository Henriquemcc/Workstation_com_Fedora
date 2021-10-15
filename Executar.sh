#!/bin/bash

# Tentando executar o script do PowerShell
pwsh ./Main.ps1

# Caso tenha ocorrido erro, tentando instalar o PowerShell para depois executar o script
if [ $? -eq 127 ]; then
  bash Install-PowerShell.sh
  pwsh ./Main.ps1
fi
