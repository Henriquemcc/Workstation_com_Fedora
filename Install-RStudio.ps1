using module "./Install-DnfPackage.ps1"

function Install-RStudio {

    <#
    .SYNOPSIS
        Installs RStudio IDE.
    .DESCRIPTION
        Installs RStudio IDE.
    #>

    Install-DnfPackage -Package @("https://download1.rstudio.org/desktop/centos8/x86_64/rstudio-1.4.1717-x86_64.rpm", "R")

}