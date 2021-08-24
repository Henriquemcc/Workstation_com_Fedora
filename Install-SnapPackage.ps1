function Install-SnapPackage
{
    param(
        [Parameter(mandatory = $true)]$Package,
        [Parameter(mandatory = $false)][switch]$Classic,
        [Parameter(mandatory = $false)][switch]$Devmode
    )

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