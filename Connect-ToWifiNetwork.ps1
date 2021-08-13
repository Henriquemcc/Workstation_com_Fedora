using module "./Test-Root.ps1"
function Connect-ToWifiNetwork {
    param(
        [Parameter(Mandatory = $true)][String]$ssid,
        [Parameter(Mandatory = $true)][SecureString]$password
    )

    if (-not (Test-Root)) {
        throw "Not root"
    }

    Invoke-Expression -Command "nmcli device wifi connect $ssid password $password"
}