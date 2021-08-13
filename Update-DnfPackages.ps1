using module "./Test-Root.ps1"

function Update-DnfPackages {

    if (-not (Test-Root)) {
        throw "Not root"
    }

    Invoke-Expression -Command "dnf --assumeyes upgrade --refresh"
}