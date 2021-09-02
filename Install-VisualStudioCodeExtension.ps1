function Install-VisualStudioCodeExtension
{
    param (
        [Parameter(Mandatory = $true)] $Extension
    )

    <#
    .SYNOPSIS
        Installs Visual Studio Code extension.
    .DESCRIPTION
        This function installs Visual Studio Code extensions.
    .EXAMPLE
        PS /> Install-VisualStudioCodeExtension -Extension "ms-python.python"
        This example installs Visual Studio Code extension Python from Microsoft.
    .EXAMPLE
        PS /> Install-VisualStudioCodeExtension -Extension @("redhat.java", "vscjava.vscode-java-debug")
        This example installs Visual Studio Code extensions Language Support for Java from RedHat and Debugger for Java from Microsoft.
    #>

    if ($Extension -is [System.String])
    {
        if ( $Extension.Contains(" "))
        {
            Install-VisualStudioCodeExtension -Extension $Extension.Split(" ")
        }

        else
        {
            Invoke-Expression -Command "code --install-extension $Extension"
        }
    }

    elseif ($Extension -is [System.Collections.ICollection])
    {
        foreach ($e in $Extension)
        {
            Install-VisualStudioCodeExtension -Extension $e
        }
    }
}