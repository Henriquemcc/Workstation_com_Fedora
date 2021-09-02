using module "./Install-SnapPackage.ps1"
function Install-VisualStudioCode
{
    <#
    .SYNOPSIS
        Installs Visual Studio Code.
    .DESCRIPTION
        This function installs Visual Studio Code.
    #>
    Install-SnapPackage -Package "code" -Classic
}