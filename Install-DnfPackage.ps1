function Install-DnfPackage
{
    param(
        [Parameter(mandatory = $true)]$Package
    )

    <#
    .SYNOPSIS
        Installs a DNF package.
    .DESCRIPTION
        This function installs DNF packages.
    .PARAMETER Package
        Package name or list of packages' name to be installed.
    .EXAMPLE
        PS /> Install-DnfPackage -Package "gcc"
        This example installs the Gnu Compiler Collection package.
    .EXAMPLE
        PS /> Install-DnfPackage -Package @("gcc", "make", "gdb")
        This example installs the packages 'gcc', 'make' and 'gdb'.
    #>

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