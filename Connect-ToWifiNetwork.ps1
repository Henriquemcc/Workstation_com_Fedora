param(
    [Parameter(Mandatory = $true)][String]$Ssid,
    [Parameter(Mandatory = $false)][SecureString]$Password = $null
)

<#
.SYNOPSIS
    Connects to a Wifi Network.
.DESCRIPTION
    This connects the computer to a wifi network.
.PARAMETER Ssid
    Wifi network Service Set Identifier (SSID).
.PARAMETER Password
    Wifi network password.
.EXAMPLE
    PS /> Connect-ToWifiNetwork -Ssid "Wifi" -Password "1234"
    This example connects to a wifi network named "Wifi" which password is "1234".
#>

$command = "sudo nmcli device wifi connect $Ssid"

if ($null -ne $Password) {
    $command += " password $Password"
}

Invoke-Expression -Command $command