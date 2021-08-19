using module "./Install-DnfPackage.ps1"

function Install-Python3Pip {
    Install-DnfPackage -Package "python3-pip"
}