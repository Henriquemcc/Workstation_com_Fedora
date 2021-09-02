#!/bin/pwsh
using module "./Update-DnfPackages.ps1"
using module "./Update-FlatpackPackages.ps1"
using module "./Update-SnapPackages.ps1"

function Update-Packages
{
    <#
    .SYNOPSIS
        Updates all packages to the latest version.
    .DESCRIPTION
        This function updates all packages from DNF, Snap and Flatpak to the latest version.
    #>
    try
    {
        Update-DnfPackages
    }

    catch
    {
        Write-Error $_
    }

    try
    {
        Update-FlatpackPackages
    }

    catch
    {
        Write-Error $_
    }

    try
    {
        Update-SnapPackages
    }

    catch
    {
        Write-Error $_
    }
}