using module "./SdkMan.ps1"

function Install-Gradle
{
    <#
    .SYNOPSIS
        Installs Gradle build tool.
    .DESCRIPTION
        This function installs Gradle build tool.
    #>

    Install-SdkMan
    Install-SdkManPackage -Package "gradle" -Version "7.2"
}