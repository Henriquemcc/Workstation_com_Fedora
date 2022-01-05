<#
.SYNOPSIS
    Installs SDK Man package manager.
.DESCRIPTION
    This installs SDK Man package manager.
#>

./Install-DnfPackage.ps1 -Package "curl"
Invoke-Expression -Command "curl -s "https://get.sdkman.io" | bash"
Invoke-Expression -Command "source ""$( $env:HOME )/.sdkman/bin/sdkman-init.sh"""