using module "./Test-Root.ps1"
function Update-SnapPackages {

    if (-not (Test-Root)) {
        throw "Not root"
    }

    Invoke-Expression -Command "snap refresh"
}