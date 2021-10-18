using module "./Install-DnfPackage.ps1"

function Install-NvidiaDriver
{
    param(
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$SignLinuxKernelModules
    )

    # Installing Nvidia driver
    Install-DnfPackage -Package "akmod-nvidia"

    if ($SignLinuxKernelModules)
    {
        Import-Module -Name "./Install-NvidiaSignedKernelModules.ps1"
        Install-NvidiaSignedKernelModules
    }

}