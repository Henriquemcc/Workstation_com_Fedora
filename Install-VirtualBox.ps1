param(
    [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$InstallExtensionPack,
    [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$SignLinuxKernelModules
)

# Installing VirtualBox
./Install-DnfPackage.ps1 -Package "VirtualBox"

if ($InstallExtensionPack)
{
    ./Install-VirtualBoxExtensionPack.ps1
}

if ($SignLinuxKernelModules)
{
    ./Install-VirtualBoxSignedKernelModules.ps1
}