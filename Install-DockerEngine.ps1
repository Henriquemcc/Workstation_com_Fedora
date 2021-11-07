<#
.SYNOPSIS
    Installs Docker Engine.
.DESCRIPTION
    Installs Docker Engine containerization technology.
#>

./Install-DnfPackage.ps1 -Package @("curl", "sudo", "bash", "shadow-utils", "coreutils", "systemd")
Invoke-Expression -Command "bash Install-DockerEngine.sh"
./Install-DnfPackage.ps1 -Package "docker-compose"