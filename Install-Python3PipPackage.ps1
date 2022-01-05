param(
    [Parameter(Mandatory = $true)]$Package
)

<#
.SYNOPSIS
    Installs Python 3 Pip package.
.DESCRIPTION
    This installs Python 3 Pip packages.
.PARAMETER Package
    Package name or list of packages' name to be installed.
.EXAMPLE
    PS /> ./Install-Python3PipPackage.ps1 -Package "youtube_dl"
    This example installs 'youtube-dl'.
.EXAMPLE
    PS /> ./Install-Python3PipPackage.ps1 -Package @("youtube_dl", "protonvpn-cli")
    This example installs 'youtube-dl' and 'protonvpn-cli'.
#>

if ($Package -is [System.String]) {
    if ( $Package.Contains(" ")) {
        ./Install-Python3PipPackage.ps1 -Package $Package.Split(" ")
    }

    else {
        Invoke-Expression -Command "pip3 install $Package"
    }
}

elseif ($Package -is [System.Collections.ICollection]) {
    foreach ($p in $Package) {
        ./Install-Python3PipPackage.ps1 -Package $p
    }
}