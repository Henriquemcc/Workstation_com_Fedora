using module "./Test-Root.ps1"

function Add-FlatpakRepository {
    param(
        [Parameter(Mandatory = $true)][string]$name,
        [Parameter(Mandatory = $true)][string]$location
    )

    if (-not (Test-Root)) {
        throw "Not root"
    }

    Invoke-Expression -Command "flatpak remote-add --if-not-exists $name $location"
}