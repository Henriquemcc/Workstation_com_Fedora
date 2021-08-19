using module "./Test-Root.ps1"

function Enable-Wifi {

    Invoke-Expression -Command "sudo nmcli radio wifi on"
}