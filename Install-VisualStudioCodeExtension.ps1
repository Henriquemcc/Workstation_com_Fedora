function Install-VisualStudioCodeExtension
{
    param (
        [Parameter(Mandatory = $true)] $extension
    )

    if ($extension.GetType() -eq [System.Object[]] -or $extension.GetType() -eq [System.String[]])
    {
        foreach ($e in $extension)
        {
            Install-VisualStudioCodeExtension -extension $e
        }
    }

    elseif ($extension.GetType() -eq [System.String])
    {

        if ( $extension.Contains(" "))
        {
            Install-VisualStudioCodeExtension -extension $extension.Split(" ")
        }

        else
        {
            Invoke-Expression -Command "code --install-extension $extension"
        }
    }
}