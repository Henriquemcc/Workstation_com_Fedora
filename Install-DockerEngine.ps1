using module "./Install-DnfPackage.ps1"
function Install-DockerEngine
{

    <#
    .SYNOPSIS
        Installs Docker Engine.
    .DESCRIPTION
        Installs Docker Engine containerization technology.
    #>

    Install-DnfPackage -Package @("curl", "sudo", "bash", "shadow-utils", "coreutils", "systemd")
    Invoke-Expression -Command "bash Install-DockerEngine.sh"
}