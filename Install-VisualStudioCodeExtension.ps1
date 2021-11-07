param (
    [Parameter(Mandatory = $true)] $Extension
)

<#
.SYNOPSIS
    Installs Visual Studio Code extension.
.DESCRIPTION
    This installs Visual Studio Code extensions.
.EXAMPLE
    PS /> ./Install-VisualStudioCodeExtension.ps1 -Extension "ms-python.python"
    This example installs Visual Studio Code extension Python from Microsoft.
.EXAMPLE
    PS /> ./Install-VisualStudioCodeExtension.ps1 -Extension @("redhat.java", "vscjava.vscode-java-debug")
    This example installs Visual Studio Code extensions Language Support for Java from RedHat and Debugger for Java from Microsoft.
#>

if ($Extension -is [System.String]) {
    if ( $Extension.Contains(" ")) {
        ./Install-VisualStudioCodeExtension.ps1 -Extension $Extension.Split(" ")
    }

    else {
        Invoke-Expression -Command "code --install-extension $Extension"
    }
}

elseif ($Extension -is [System.Collections.ICollection]) {
    foreach ($e in $Extension) {
        ./Install-VisualStudioCodeExtension.ps1 -Extension $e
    }
}