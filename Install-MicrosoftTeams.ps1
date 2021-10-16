using module "./Install-DnfPackage.ps1"

function Install-MicrosoftTeams
{

    <#
    .SYNOPSIS
        Installs Microsoft Teams.
    .DESCRIPTION
        Installs Microsoft Teams.
    #>

    $urlMicrosoftTeams = (Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/p/?LinkID=2112907&clcid=0x409&culture=en-us&country=US").BaseResponse.RequestMessage.RequestUri.AbsoluteUri

    Install-DnfPackage -Package $urlMicrosoftTeams

}