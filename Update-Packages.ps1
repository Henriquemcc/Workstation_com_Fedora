<#
.SYNOPSIS
    Updates all packages to the latest version.
.DESCRIPTION
    This function updates all packages from DNF, Snap and Flatpak to the latest version.
#>
try {
    ./Update-DnfPackages.ps1
}

catch {
    Write-Error $_
}

try {
    ./Update-FlatpackPackages.ps1
}

catch {
    Write-Error $_
}

try {
    ./Update-SnapPackages.ps1
}

catch {
    Write-Error $_
}