function Install-Python3PipPackage
{
    param(
        [Parameter(Mandatory = $true)]$Package
    )

    if ($Package -is [System.String])
    {
        if ( $Package.Contains(" "))
        {
            Install-Python3PipPackage -Package $Package.Split(" ")
        }

        else
        {
            Invoke-Expression -Command "pip3 install $Package"
        }
    }

    elseif ($Package -is [System.Collections.ICollection])
    {
        foreach ($p in $Package)
        {
            Install-Python3PipPackage -Package $p
        }
    }

}