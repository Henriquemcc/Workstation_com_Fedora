function Install-Python3PipPackage {
    param(
        [Parameter(Mandatory = $true)]$package
    )

    if ($package -is [System.Collections.IEnumerable]) {
        foreach ($p in $package) {
            Install-Python3PipPackage -package $p
        }
    }

    elseif ($package -is [System.String]) {

        if ( $package.Contains(" ")) {
            Install-Python3PipPackage -package $package.Split(" ")
        }

        else {
            Invoke-Expression -Command "pip3 install $package"
        }
    }

}