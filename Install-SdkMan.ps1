using module "./Install-DnfPackage.ps1"
function Install-SdkMan
{
    Install-DnfPackage -Package "curl"
    Invoke-Expression -Command "curl -s "https://get.sdkman.io" | bash"
    Invoke-Expression -Command "source ""$( $env:HOME )/.sdkman/bin/sdkman-init.sh"""
}