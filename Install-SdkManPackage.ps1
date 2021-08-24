function Install-SdkManPackage
{
    param(
        [Parameter(Mandatory = $true)][System.String]$Package,
        [Parameter(Mandatory = $true)][System.String]$Version
    )

    Invoke-Expression -Command "sdk install $Package $Version"
}