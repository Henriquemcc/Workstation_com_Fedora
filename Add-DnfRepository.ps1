using module "./Test-Root.ps1"

function Add-DnfRepository {
    param (
        [Parameter(Mandatory = $true)]$repository
    )

    if (-not (Test-Root)) {
        throw "Not root"
    }

    Invoke-Expression -Command "dnf --assumeyes config-manager --add-repo=$repository"
}