function Disable-Wifi
{
    <#
    .SYNOPSIS
        Disable wifi adapter.
    .DESCRIPTION
        This function disables the wifi adapter.
    #>

    Install-DnfPackage -Package @("sudo", "NetworkManager")
    Invoke-Expression -Command "bash Disable-Wifi.sh"
}