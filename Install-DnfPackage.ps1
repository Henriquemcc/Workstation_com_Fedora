using module "./Test-Root.ps1"

function Install-DnfPackage {
    param(
        [Parameter(mandatory = $true)]$Package
    )

    if ($Package -is [System.Collections.IEnumerable]) {
        foreach ($p in $Package) {
            Install-DnfPackage -Package $p
        }
    }

    elseif ($Package -is [System.String]) {
        if ( $Package.Contains(" ")) {
            Install-DnfPackage -Package $Package.Split(" ")
        }
        else {
            Invoke-Expression -Command "sudo dnf --assumeyes --best install $Package"
        }
    }
}