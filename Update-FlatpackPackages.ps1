param(
    [Parameter(Mandatory = $false)][switch]$User
)

<#
.SYNOPSIS
    Updates all Flatpak packages
.DESCRIPTION
    This updates all Flatpak packages to the latest version.
#>

# Checking if flatpak is installed
$flatpakIsInstalled = ./Test-Expression.ps1 -Command "flatpak"
if (-not$flatpakIsInstalled) {
    Invoke-Expression -Command "bash ./Install-Flatpak.sh"
}

$command = "flatpak update --assumeyes"

if ($User) {
    $command += " --user"
}

else {
    $command += " --system"
    $command = "sudo $command"
}

Invoke-Expression -Command $command