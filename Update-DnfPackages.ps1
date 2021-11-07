<#
.SYNOPSIS
    Updates all DNF Packages to the latest version.
.DESCRIPTION
    This updates all DNF Packages to the latest version.
#>

Invoke-Expression -Command "sudo dnf --assumeyes upgrade --refresh"