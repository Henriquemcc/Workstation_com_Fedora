using module "./Install-SnapPackage.ps1"
function Install-VisualStudioCode {
    Install-SnapPackage -Package "code" -Classic
}