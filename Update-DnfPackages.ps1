function Update-DnfPackages
{
    Invoke-Expression -Command "sudo dnf --assumeyes upgrade --refresh"
}