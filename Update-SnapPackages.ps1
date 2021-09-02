function Update-SnapPackages
{
    <#
    .SYNOPSIS
        Updates all Snap packages.
    .DESCRIPTION
        This function updates all Snap packages to the latest version.
    #>
    Invoke-Expression -Command "sudo snap refresh"
}