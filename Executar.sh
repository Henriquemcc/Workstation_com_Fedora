#!/bin/bash

# try
{
	# Tentando executar o script do PowerShell
	pwsh ./Main.ps1

} || { # catch

	# Caso tenha ocorrido erro, tentando instalar o PowerShell para depois executar o script
	sudo dnf --assumeyes install https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-1.centos.8.x86_64.rpm
	pwsh ./Main.ps1
}
