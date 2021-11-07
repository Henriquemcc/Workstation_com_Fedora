param(
    [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$SignLinuxKernelModules
)

# Installing Nvidia driver
./Install-DnfPackage -Package "akmod-nvidia"

if ($SignLinuxKernelModules) {
    ./Install-NvidiaSignedKernelModules.ps1
}