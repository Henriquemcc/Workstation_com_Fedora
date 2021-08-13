using module "./Test-Root.ps1"

function Install-DnfPackage {
    param(
        [Parameter(mandatory = $true)]$package
    )

    if (-not (Test-Root)) {
        throw "Not root"
    }

    if ($package.GetType() -eq [System.Object[]] -or $package.GetType() -eq [System.String[]]) {
        foreach ($p in $package) {
            Install-DnfPackage -package $p
        }
    }

    elseif ($package.GetType() -eq [System.String]) {
        if ( $package.Contains(" ")) {
            Install-DnfPackage -package $package.Split(" ")
        }
        else {
            Invoke-Expression -Command "dnf --assumeyes --best install $package"
        }
    }
}