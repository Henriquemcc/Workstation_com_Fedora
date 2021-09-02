using module "./Add-NvidiaSignedModulesToLinuxKernel.ps1"
using module "./Add-VirtualboxSignedModulesToLinuxKernel.ps1"
using module "./New-AsymmetricPairOfKeysToSignKernelModules.ps1"

function Install-SignedKernelModules
{
    <#
    .SYNOPSIS
        Sign and install kernel modules.
    .DESCRIPTION
        This function sign and install Linux kernel modules from Nvidia and VirtualBox.
    #>

    # Creating a pair of assimetric keys
    $pairOfKeys = New-AsymmetricPairOfKeysToSignKernelModules

    # Adding Nvidia kernel modules
    Add-NvidiaSignedModulesToLinuxKernel $pairOfKeys[0] $pairOfKeys[1]

    # Adding VirtualBox kernel modules
    Add-VirtualboxSignedModulesToLinuxKernel $pairOfKeys[0] $pairOfKeys[1]
}