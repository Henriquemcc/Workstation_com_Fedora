function Update-DnfPackages
{
    Invoke-Expression -Command "dnf --assumeyes upgrade --refresh"
}