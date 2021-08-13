using module "./Test-Root.ps1"
function Update-FlatpackPackages {
    if (-not (Test-Root)) {
        throw "Not root"
    }

    Invoke-Expression -Command "flatpak update --assumeyes"
}