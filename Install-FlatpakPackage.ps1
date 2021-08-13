using module "./Test-Root.ps1"

function Install-FlatpakPackage {
    param(
        [Parameter(Mandatory = $true)]$package,
        [Parameter(Mandatory = $false)][switch]$user
    )

    if (-not (Test-Root)) {
        throw "Not root"
    }

    if ($package.GetType() -eq [System.Object[]] -or $package.GetType() -eq [System.String[]]) {
        foreach ($p in $package) {
            Install-FlatpakPackage -package $p
        }
    }

    elseif ($package.GetType() -eq [System.String]) {

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