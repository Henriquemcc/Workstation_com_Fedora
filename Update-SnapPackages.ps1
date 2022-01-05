<#
.SYNOPSIS
    Updates all Snap packages.
.DESCRIPTION
    This updates all Snap packages to the latest version.
#>

# Checking if snapd is installed
$snapdIsInstalled = ./Test-Expression.ps1 -Command "snap"
if (-not$snapdIsInstalled) {
    Invoke-Expression -Command "bash ./Install-Snapd.sh"
}

Invoke-Expression -Command "sudo snap refresh"