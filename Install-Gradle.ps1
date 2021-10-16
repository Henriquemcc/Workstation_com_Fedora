using module "./SdkMan.ps1"
using module "./Test-Expression.ps1"

function Install-Gradle
{
    <#
    .SYNOPSIS
        Installs Gradle build tool.
    .DESCRIPTION
        This function installs Gradle build tool.
    #>

    # Checking if sdkMan is installed
    $sdkManIsInstalled = Test-Expression -Command "sdk"
    if (-not$sdkManIsInstalled)
    {
        Install-SdkMan
    }

    Install-SdkManPackage -Package "gradle" -Version "7.2"
}