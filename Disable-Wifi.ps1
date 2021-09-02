function Disable-Wifi
{
    <#
    .SYNOPSIS
        Disable wifi adapter.
    .DESCRIPTION
        This function disables the wifi adapter.
    #>
    Invoke-Expression -Command "sudo nmcli radio wifi off"
}