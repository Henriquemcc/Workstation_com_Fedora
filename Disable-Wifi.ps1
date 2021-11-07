<#
.SYNOPSIS
    Disable wifi adapter.
.DESCRIPTION
    This disables the wifi adapter.
#>

./Install-DnfPackage.ps1 -Package @("sudo", "NetworkManager")
Invoke-Expression -Command "bash Disable-Wifi.sh"