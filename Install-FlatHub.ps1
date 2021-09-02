using module "./Add-FlatpakRepository.ps1"

function Install-FlatHub
{

    <#
    .SYNOPSIS
        Installs FlatHub repository.
    .DESCRIPTION
        This function installs FlatHub repository in FlatPak.
    #>

    Add-FlatpakRepository -Name "flathub" -Location "https://flathub.org/repo/flathub.flatpakrepo"
}