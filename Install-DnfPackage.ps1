param(
    [Parameter(mandatory = $true)]$Package
)

<#
.SYNOPSIS
    Installs a DNF package.
.DESCRIPTION
    This installs DNF packages.
.PARAMETER Package
    Package name or list of packages' name to be installed.
.EXAMPLE
    PS /> ./Install-DnfPackage.ps1 -Package "gcc"
    This example installs the Gnu Compiler Collection package.
.EXAMPLE
    PS /> ./Install-DnfPackage.ps1 -Package @("gcc", "make", "gdb")
    This example installs the packages 'gcc', 'make' and 'gdb'.
#>

if ($Package -is [System.String]) {
    if ( $Package.Contains(" ")) {
        ./Install-DnfPackage.ps1 -Package $Package.Split(" ")
    }
    else {
        Invoke-Expression -Command "sudo dnf --assumeyes install $Package"
    }
}

elseif ($Package -is [System.Collections.ICollection]) {
    foreach ($p in $Package) {
        ./Install-DnfPackage.ps1 -Package $p
    }
}