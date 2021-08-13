function Add-FlatpakRepository {
    param(
        [Parameter(Mandatory = $true)][string]$name,
        [Parameter(Mandatory = $true)][string]$location
    )

    Invoke-Expression -Command "flatpak remote-add --if-not-exists $name $location"
}