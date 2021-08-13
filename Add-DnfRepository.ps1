function Add-DnfRepository {
    param (
        [Parameter(Mandatory = $true)]$repository
    )
    Invoke-Expression -Command "dnf --assumeyes config-manager --add-repo=$repository"
}