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