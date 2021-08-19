using module "./Test-Root.ps1"
function Update-FlatpackPackages {
    param(
        [Parameter(Mandatory = $false)][switch]$User
    )

    $command = "flatpak update --assumeyes"

    if ($User) {
        $command += " --user"
    }

    else {
        $command += " --system"
        $command = "sudo $command"
    }

    Invoke-Expression -Command $command
}