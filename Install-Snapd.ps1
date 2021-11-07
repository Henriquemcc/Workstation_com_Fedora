<#
.SYNOPSIS
    Installs Snap package manager.
.DESCRIPTION
    This installs Snap's snapd package manager.
#>

./Install-DnfPackage.ps1 -Package "snapd"
Invoke-Expression -Command "sudo systemctl enable --now snapd.socket"
Invoke-Expression -Command "sudo ln -s /var/lib/snapd/snap /snap"