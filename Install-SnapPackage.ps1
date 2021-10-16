using module "./Install-Snapd.ps1"
using module "./Test-Expression.ps1"

function Install-SnapPackage
{
    param(
        [Parameter(mandatory = $true)]$Package,
        [Parameter(mandatory = $false)][switch]$Classic,
        [Parameter(mandatory = $false)][switch]$Devmode
    )

    <#
    .SYNOPSIS
        Install Snap package.
    .DESCRIPTION
        This function installs Snap packages.
    .PARAMETER Package
        Package's name to be installed or list of packages' name.
    .PARAMETER Classic
        Put snap in classic mode and disable security confinement.
    .PARAMETER Devmode
        Put snap in development mode and disable security confinement.
    .EXAMPLE
        PS /> Install-SnapPackage -Package "spotify"
        This example installs Spotify.
    .EXAMPLE
        PS /> Install-SnapPackage -Package @("spotify", "skype")
        This example installs Spotify and Skype.
    .EXAMPLE
        PS /> Install-SnapPackage -Package "code" -Classic
        This example installs Visual Studio Code in classic mode, without security confinement.
    #>

    # Checking if snapd is installed
    $snapdIsInstalled = Test-Expression -Command "snap"
    if (-not$snapdIsInstalled)
    {
        Install-Snapd
    }


    if ($Package -is [System.String])
    {
        if ( $Package.Contains(" "))
        {
            Install-SnapPackage -Package $Package.Split(" ") -Classic:$Classic -Devmode:$Devmode
        }

        else
        {
            $command = "sudo snap install $Package"

            if ($Classic)
            {
                $command += " --classic"
            }

            if ($Devmode)
            {
                $command += " --devmode"
            }

            Invoke-Expression -Command $command
        }
    }

    elseif ($Package -is [System.Collections.ICollection])
    {
        foreach ($p in $Package)
        {
            Install-SnapPackage -Package $p -Classic:$Classic -Devmode:$Devmode
        }
    }
}