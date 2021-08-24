function Install-DnfPackage
{
    param(
        [Parameter(mandatory = $true)]$Package
    )

    if ($Package -is [System.String])
    {
        if ( $Package.Contains(" "))
        {
            Install-DnfPackage -Package $Package.Split(" ")
        }
        else
        {
            Invoke-Expression -Command "sudo dnf --assumeyes install $Package"
        }
    }

    elseif ($Package -is [System.Collections.ICollection])
    {
        foreach ($p in $Package)
        {
            Install-DnfPackage -Package $p
        }
    }
}