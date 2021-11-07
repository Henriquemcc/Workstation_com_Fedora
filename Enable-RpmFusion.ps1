<#
.SYNOPSIS
    Enables RPM Fusion repository.
.DESCRIPTION
    This enables RPM Fusion repository.
#>

./Install-DnfPackage.ps1 -Package @(
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$( rpm -E %fedora ).noarch.rpm",
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$( rpm -E %fedora ).noarch.rpm",
    "rpmfusion-free-release-tainted","rpmfusion-nonfree-release-tainted")
