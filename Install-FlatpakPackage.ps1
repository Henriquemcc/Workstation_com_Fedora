using module "./Test-Root.ps1"

function Install-FlatpakPackage {
    param(
        [Parameter(Mandatory = $true)]$Package,
        [Parameter(Mandatory = $false)][switch]$User
    )

    if ($Package -is [System.Collections.IEnumerable]) {
        foreach ($p in $Package) {
            Install-FlatpakPackage -Package $p -User:$User
        }
    }

    elseif ($Package -is [System.String]) {

        if ( $Package.Contains(" ")) {
            Install-FlatpakPackage -Package $Package.Split(" ") -User:$User
        }

        else {
            $command = "flatpak install --assumeyes"

            if ($User) {
                $command += " --user"
            }

            else {
                $command += " --system"
                $command = "sudo $command"
            }

            $command += " $Package"

            Invoke-Expression -Command $command
        }
    }
}