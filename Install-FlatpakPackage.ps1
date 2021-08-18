using module "./Test-Root.ps1"

function Install-FlatpakPackage {
    param(
        [Parameter(Mandatory = $true)]$package,
        [Parameter(Mandatory = $false)][switch]$user
    )

    if ($package -is [System.Collections.IEnumerable]) {
        foreach ($p in $package) {
            Install-FlatpakPackage -package $p
        }
    }

    elseif ($package -is [System.String]) {

        if ( $package.Contains(" ")) {
            Install-FlatpakPackage -package $package.Split(" ")
        }

        else {
            $command = "flatpak install --assumeyes"

            if (-not$user) {
                $command += " --system"
            }

            $command += " $package"

            Invoke-Expression -Command $command
        }
    }
}