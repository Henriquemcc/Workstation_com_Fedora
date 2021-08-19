using module "./Test-Root.ps1"
function Update-SnapPackages {

    Invoke-Expression -Command "sudo snap refresh"
}