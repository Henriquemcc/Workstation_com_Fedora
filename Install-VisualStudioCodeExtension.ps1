function Install-VisualStudioCodeExtension
{
    param (
        [Parameter(Mandatory = $true)] $Extension
    )

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