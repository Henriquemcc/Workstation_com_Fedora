using module "./Test-Root.ps1"

function Enable-Wifi {

    if (-not (Test-Root)) {
        throw "Not root"
    }

    Invoke-Expression -Command "nmcli radio wifi on"
}