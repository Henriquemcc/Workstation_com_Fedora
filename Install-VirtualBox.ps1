using module "./Install-DnfPackage.ps1"

function Install-VirtualBox
{
    param(
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$InstallExtensionPack,
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$SignLinuxKernelModules
    )
    # Installing VirtualBox
    Install-DnfPackage -Package "VirtualBox"

    if ($InstallExtensionPack)
    {
        Import-Module -Name "./Install-VirtualBoxExtensionPack.ps1"
        Install-VirtualBoxExtensionPack
    }

    if ($SignLinuxKernelModules)
    {
        Import-Module -Name "./Install-VirtualBoxSignedKernelModules.ps1"
        Install-VirtualBoxSignedKernelModules
    }
}