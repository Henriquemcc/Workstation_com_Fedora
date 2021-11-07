<#
.SYNOPSIS
    Enables wifi adapter.
.DESCRIPTION
    This enables the wifi adapter.
#>

./Install-DnfPackage.ps1 -Package @("sudo", "NetworkManager")
Invoke-Expression -Command "bash Enable-Wifi.sh"