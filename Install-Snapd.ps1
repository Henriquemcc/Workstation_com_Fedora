using module "./Install-DnfPackage.ps1"

function Install-Snapd
{

    <#
    .SYNOPSIS
        Installs Snap package manager.
    .DESCRIPTION
        This function installs Snap's snapd package manager.
    #>

    Install-DnfPackage -Package "snapd"
    Invoke-Expression -Command "sudo systemctl enable --now snapd.socket"
    Invoke-Expression -Command "sudo ln -s /var/lib/snapd/snap /snap"
}