using module "./Test-Root.ps1"

function Disable-Wifi {

    if (-not (Test-Root)) {
        throw "Not root"
    }

    Invoke-Expression -Command "nmcli radio wifi off"
}