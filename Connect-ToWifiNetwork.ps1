function Connect-ToWifiNetwork
{
    param(
        [Parameter(Mandatory = $true)][String]$Ssid,
        [Parameter(Mandatory = $false)][SecureString]$Password = $null
    )

    $command = "sudo nmcli device wifi connect $Ssid"

    if ($null -ne $Password)
    {
        $command += " password $Password"
    }

    Invoke-Expression -Command $command
}