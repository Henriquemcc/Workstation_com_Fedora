function Update-DnfPackages
{
    <#
    .SYNOPSIS
        Updates all DNF Packages to the latest version.
    .DESCRIPTION
        This function updates all DNF Packages to the latest version.
    #>
    Invoke-Expression -Command "sudo dnf --assumeyes upgrade --refresh"
}