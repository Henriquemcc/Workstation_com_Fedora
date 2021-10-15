using module "./Test-Expression.ps1"
using module "./Install-Snapd.ps1"
function Update-SnapPackages
{
    <#
    .SYNOPSIS
        Updates all Snap packages.
    .DESCRIPTION
        This function updates all Snap packages to the latest version.
    #>

    # Checking if snapd is installed
    $snapdIsInstalled = Test-Expression -Command "snap"
    if (-not $snapdIsInstalled){
        Install-Snapd
    }

    Invoke-Expression -Command "sudo snap refresh"
}