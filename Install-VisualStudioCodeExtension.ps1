function Install-VisualStudioCodeExtension {
    param (
        [Parameter(Mandatory = $true)] $extension
    )

    if ($extension -is [System.Collections.IEnumerable]) {
        foreach ($e in $extension) {
            Install-VisualStudioCodeExtension -extension $e
        }
    }

    elseif ($extension -is [System.String]) {

        if ( $extension.Contains(" ")) {
            Install-VisualStudioCodeExtension -extension $extension.Split(" ")
        }

        else {
            Invoke-Expression -Command "code --install-extension $extension"
        }
    }
}