using module "./Install-DnfPackage.ps1"

function Install-ProtonVPN
{

    <#
    .SYNOPSIS
        Installs Proton VPN.
    .DESCRIPTION
        Installs Proton VPN.
    #>

    Install-DnfPackage -Package @("https://protonvpn.com/download/protonvpn-beta-release-1.0.0-1.noarch.rpm", "protonvpn")

}