using module "./Install-DnfPackage.ps1"

function Install-Python3Pip
{

    <#
    .SYNOPSIS
        Installs Python 3 Pip Package Manager.
    .DESCRIPTION
        This function installs Python 3 Pip Package Manager.
    #>

    Install-DnfPackage -Package "python3-pip"
}