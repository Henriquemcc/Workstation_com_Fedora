function Install-SdkManPackage
{
    param(
        [Parameter(Mandatory = $true)][System.String]$Package,
        [Parameter(Mandatory = $true)][System.String]$Version
    )

    <#
    .SYNOPSIS
        Installs SDK Man package.
    .DESCRIPTION
        This function installs SDK Man package.
    .PARAMETER Package
        Name of the candidate package to be installed.
    .PARAMETER Version
        Version of the candidate package to be installed.
    .EXAMPLE
        PS /> Install-SdkManPackage -Package "gradle" -Version "7.2"
        This example installs the version 7.2 of gradle.
    #>

    Invoke-Expression -Command "sdk install $Package $Version"
}