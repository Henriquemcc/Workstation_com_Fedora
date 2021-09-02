function Enable-Wifi
{
    <#
    .SYNOPSIS
        Enables wifi adapter.
    .DESCRIPTION
        This function enables the wifi adapter.
    #>

    Invoke-Expression -Command "sudo nmcli radio wifi on"
}