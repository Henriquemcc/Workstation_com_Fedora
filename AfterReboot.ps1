using module "./Add-VirtualboxSignedModulesToLinuxKernel.ps1"
using module "./Test-Root.ps1"

function Main {

    if (-not (Test-Root)) {
        throw "Not root"
    }

    Add-VirtualboxSignedModulesToLinuxKernel
}

Main