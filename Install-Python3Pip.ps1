using module "./Install-DnfPackage.ps1"

function Install-Python3Pip
{
    Install-DnfPackage -package "python3-pip"
}