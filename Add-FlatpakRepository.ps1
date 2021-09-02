function Add-FlatpakRepository
{
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Location,
        [Parameter(Mandatory = $false)][switch]$User
    )

    <#
    .SYNOPSIS
        Adds a repository to Flatpak package manager.
    .DESCRIPTION
        This function adds a Flatpak package manager repository.
    .PARAMETER Name
        Name for the new remote.
    .PARAMETER Location
        Url or path name of the location of the remote repository.
    .PARAMETER User
        Modify the per-user configuration.
    .EXAMPLE
        PS /> Add-FlatpakRepository -Name "flathub" -Location "https://flathub.org/repo/flathub.flatpakrepo"
        This example adds Flathub repository to Flatpak package manager.
    #>

    $command = "flatpak remote-add --if-not-exists"

    if ($User)
    {
        $command += " --user"
    }

    else
    {
        $command += " --system"
        $command = "sudo $command"
    }

    $command += " $Name $Location"

    Invoke-Expression -Command $command
}