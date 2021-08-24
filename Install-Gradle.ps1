using module "./SdkMan.ps1"

function Install-Gradle
{
    Install-SdkMan
    Install-SdkManPackage -Package "gradle" -Version "7.2"
}