using module "./Test-Expression.ps1"
using module "./Install-Flatpak.ps1"

function Update-FlatpackPackages
{
    param(
        [Parameter(Mandatory = $false)][switch]$User
    )

    <#
    .SYNOPSIS
        Updates all Flatpak packages
    .DESCRIPTION
        This function updates all Flatpak packages to the latest version.
    #>

    # Checking if flatpak is installed
    $flatpakIsInstalled = Test-Expression -Command "flatpak"
    if (-not$flatpakIsInstalled)
    {
        Install-Flatpak
    }

    $command = "flatpak update --assumeyes"

    if ($User)
    {
        $command += " --user"
    }

    else
    {
        $command += " --system"
        $command = "sudo $command"
    }

    Invoke-Expression -Command $command
}