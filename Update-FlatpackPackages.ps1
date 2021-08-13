function Update-FlatpackPackages
{
    Invoke-Expression -Command "flatpak update --assumeyes"
}