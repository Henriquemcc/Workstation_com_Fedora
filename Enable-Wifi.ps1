function Enable-Wifi
{
    <#
    .SYNOPSIS
        Enables wifi adapter.
    .DESCRIPTION
        This function enables the wifi adapter.
    #>

    Install-DnfPackage -Package @("sudo", "NetworkManager")
    Invoke-Expression -Command "bash Enable-Wifi.sh"
}