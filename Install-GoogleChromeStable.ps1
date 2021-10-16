using module "./Install-DnfPackage.ps1"

function Install-GoogleChromeStable
{
    <#
    .SYNOPSIS
        Installs Google Chrome.
    .DESCRIPTION
        Installs Google Chrome stable version.
    #>

    Install-DnfPackage -Package "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
}