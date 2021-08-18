using module "./Test-Root.ps1"

function Install-SnapPackage {
    param(
        [Parameter(mandatory = $true)]$package,
        [Parameter(mandatory = $false)][switch]$classic,
        [Parameter(mandatory = $false)][switch]$devmode
    )

    if (-not (Test-Root)) {
        throw "Not root"
    }

    if ($package -is [System.Collections.IEnumerable]) {
        foreach ($p in $package) {
            Install-SnapPackage -package $p -classic:$classic -devmode:$devmode
        }
    }

    elseif ($package -is [System.String]) {
        if ( $package.Contains(" ")) {
            Install-SnapPackage -package $package.Split(" ") -classic:$classic -devmode:$devmode
        }

        else {

            $command = "snap install $package"

            if ($classic) {
                $command += " --classic"
            }

            if ($devmode) {
                $command += " --devmode"
            }

            Invoke-Expression -Command $command
        }
    }
}