function Connect-ToWifiNetwork {
    param(
        [Parameter(Mandatory = $true)][String]$ssid,
        [Parameter(Mandatory = $true)][SecureString]$password
    )

    Invoke-Expression -Command "nmcli device wifi connect $ssid password $password"
}