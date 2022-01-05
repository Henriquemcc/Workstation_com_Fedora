<#
.SYNOPSIS
    Installs Gradle build tool.
.DESCRIPTION
    This installs Gradle build tool.
#>

# Checking if sdkMan is installed
$sdkManIsInstalled = ./Test-Expression.ps1 -Command "sdk"
if (-not$sdkManIsInstalled)
{
    ./Install-SdkMan.ps1
}

./Install-SdkManPackage.ps1 -Package "gradle" -Version "7.2"