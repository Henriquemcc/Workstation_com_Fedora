using module "./Install-DnfPackage.ps1"

function Enable-RpmFusion
{

    <#
    .SYNOPSIS
        Enables RPM Fusion repository.
    .DESCRIPTION
        This function enables RPM Fusion repository.
    #>

    Install-DnfPackage -Package @(
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$( rpm -E %fedora ).noarch.rpm",
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$( rpm -E %fedora ).noarch.rpm"),
    "rpmfusion-free-release-tainted",
    "rpmfusion-nonfree-release-tainted"
}