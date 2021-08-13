#!/bin/pwsh
using module "./Update-DnfPackages.ps1"
using module "./Update-FlatpackPackages.ps1"
using module "./Update-SnapPackages.ps1"

function Update-Packages {
    Update-DnfPackages
    Update-FlatpackPackages
    Update-SnapPackages
}