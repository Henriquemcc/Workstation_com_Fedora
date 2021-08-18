function Set-ItemPermission {

    <#
    Reference:
    https://linux.die.net/man/1/chmod
    https://en.wikipedia.org/wiki/Chmod#:~:text=chmod%20%5Boptions%5D%20mode%5B%2Cmode%5D%20file1%20%5Bfile2%20...%5D
    #>

    param(

        # Like verbose but report only when a change is made
        [Parameter(Mandatory = $false)]
        [Alias("c")]
        [switch] $changes,

        # Do not treat '/' specially (the default)
        [Parameter(Mandatory = $false)]
        [switch] $noPreserveRoot,

        # Fail to operate recursively on '/'
        [Parameter(Mandatory = $false)]
        [switch] $preserveRoot,

        # Suppress most error messages
        [Parameter(Mandatory = $false)]
        [Alias("f", "quiet")]
        [switch] $silent,

        # Use RFILE's mode instead of MODE values
        [Parameter(Mandatory = $false)]
        [string] $reference = $null,

        # Change files and directories recursively
        [Parameter(Mandatory = $false)]
        [Alias("R")]
        [switch] $recursive,

        # Display help and exit
        [Parameter(Mandatory = $false)]
        [switch] $help,

        # Output version information and exit
        [Parameter(Mandatory = $false)]
        [switch] $version,

        # Mode
        [Parameter(Mandatory = $false)] $mode = $null,

        # File
        [Parameter(Mandatory = $false)] $file = $null
    )

    $command = "chmod"

    if ($changes) {
        $command += " --changes"
    }

    if ($noPreserveRoot) {
        $command += " --no-preserve-root"
    }

    if ($preserveRoot) {
        $command += " --preserve-root"
    }

    if ($silent) {
        $command += " --silent"
    }

    if ($verbose) {
        $command += " --verbose"
    }

    if (($null -ne $reference) -and ($reference.Length -gt 0)) {
        $command += " --reference=$reference"
    }

    if ($recursive) {
        $command += " --recursive"
    }

    if ($help) {
        $command += " --help"
    }

    if ($version) {
        $command += " --version"
    }

    if ($null -ne $mode) {

        if ($mode -is [System.Collections.IEnumerable]) {

            $modeString = ""

            foreach ($m in $mode) {
                $modeString += "$m, "
            }

            $modeString = $modeString.Remove($modeString.LastIndexOf(", "))

            $command += " $modeString"
        }

        elseif (($mode -is [string]) -and ($mode.Length -gt 0)) {
            $command += " $mode"
        }
    }

    if ($null -ne $file) {
        if ($file -is [System.Collections.IEnumerable]) {

            $fileString = ""

            foreach ($f in $file) {
                $fileString += "$f "
            }

            $fileString = $fileString.Remove($fileString.LastIndexOf(" "))

            $command += " $fileString"

        }

        elseif (($file -is [string]) -and ($file.Length -gt 0)) {
            $command += " $file"
        }
    }

    Invoke-Expression -Command $command

}