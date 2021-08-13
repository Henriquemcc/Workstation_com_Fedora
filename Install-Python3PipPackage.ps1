function Install-Python3PipPackage
{
    param(
        [Parameter(Mandatory = $true)]$package
    )

    if ($package.GetType() -eq [System.Object[]] -or $package.GetType() -eq [System.String[]])
    {
        foreach ($p in $package)
        {
            Install-Python3PipPackage -package $p
        }
    }

    elseif ($package.GetType() -eq [System.String])
    {

        if ( $package.Contains(" "))
        {
            Install-Python3PipPackage -package $package.Split(" ")
        }

        else
        {
            Invoke-Expression -Command "pip3 install $package"
        }
    }

}