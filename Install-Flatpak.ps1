using module "./Install-DnfPackage.ps1"

function Install-Flatpak {
    
    Install-DnfPackage -Package "flatpak"
}