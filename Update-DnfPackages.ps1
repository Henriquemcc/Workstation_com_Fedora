using module "./Test-Root.ps1"

function Update-DnfPackages {

    Invoke-Expression -Command "sudo dnf --assumeyes upgrade --refresh"
}