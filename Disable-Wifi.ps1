using module "./Test-Root.ps1"

function Disable-Wifi {

    Invoke-Expression -Command "sudo nmcli radio wifi off"
}