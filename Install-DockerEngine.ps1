<#
.SYNOPSIS
    Installs Docker Engine.
.DESCRIPTION
    Installs Docker Engine containerization technology.
#>

./Install-DnfPackage.ps1 -Package @("curl", "sudo", "bash", "shadow-utils", "coreutils", "systemd", "fuse-overlayfs", "iptables", "docker-compose")
Invoke-Expression -Command "bash Install-Docker.sh"