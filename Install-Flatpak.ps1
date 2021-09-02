using module "./Install-DnfPackage.ps1"

function Install-Flatpak
{

    <#
    .SYNOPSIS
        Installs Flatpak package manager.
    .DESCRIPTION
        This function installs Flatpak package manager.
    #>

    Install-DnfPackage -Package "flatpak"
}