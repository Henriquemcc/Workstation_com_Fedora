using module "./Install-DnfPackage.ps1"

function Install-Peazip
{

    <#
    .SYNOPSIS
        Installs Peazip.
    .DESCRIPTION
        Installs Peazip.
    #>

    Install-DnfPackage -Package "https://github.com/peazip/PeaZip/releases/download/8.2.0/peazip-8.2.0.LINUX.GTK2-1.x86_64.rpm"

}