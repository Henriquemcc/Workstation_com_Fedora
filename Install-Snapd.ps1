using module "./Install-DnfPackage.ps1"

function Install-Snapd {
    Install-DnfPackage -package "snapd"
    Invoke-Expression -Command "systemctl enable --now snapd.socket"
    Invoke-Expression -Command "ln -s /var/lib/snapd/snap /snap"
}