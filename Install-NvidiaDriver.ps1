param(
    [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$SignLinuxKernelModules
)

# Installing Nvidia driver
./Install-DnfPackage -Package @("akmod-nvidia", "xorg-x11-drv-nvidia-cuda")

if ($SignLinuxKernelModules) {
    ./Install-NvidiaSignedKernelModules.ps1
}