using module "./Add-NvidiaSignedModulesToLinuxKernel.ps1"
using module "./Add-VirtualboxSignedModulesToLinuxKernel.ps1"
using module "./New-AsymmetricPairOfKeysToSignKernelModules.ps1"
using module "./Test-Root.ps1"

function Install-SignedKernelModules {

    # Criando um par de chaves
    $pairOfKeys = New-AsymmetricPairOfKeysToSignKernelModules

    # Adicionando módulos da Nvidia no kernel
    Add-NvidiaSignedModulesToLinuxKernel $pairOfKeys[0] $pairOfKeys[1]

    # Adicionando módulos do VirtualBox no Kernel
    Add-VirtualboxSignedModulesToLinuxKernel $pairOfKeys[0] $pairOfKeys[1]
}