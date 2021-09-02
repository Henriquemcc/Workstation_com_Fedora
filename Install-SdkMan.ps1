using module "./Install-DnfPackage.ps1"
function Install-SdkMan
{
    <#
    .SYNOPSIS
        Installs SDK Man package manager.
    .DESCRIPTION
        This function installs SDK Man package manager.
    #>

    Install-DnfPackage -Package "curl"
    Invoke-Expression -Command "curl -s "https://get.sdkman.io" | bash"
    Invoke-Expression -Command "source ""$( $env:HOME )/.sdkman/bin/sdkman-init.sh"""
}