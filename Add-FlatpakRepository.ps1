using module "./Test-Root.ps1"

function Add-FlatpakRepository {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Location,
        [Parameter(Mandatory = $false)][switch]$User
    )

    $command = "flatpak remote-add --if-not-exists"

    if ($User) {
        $command += " --user"
    }

    else {
        $command += " --system"
        $command = "sudo $command"
    }

    $command += " $Name $Location"

    Invoke-Expression -Command $command
}