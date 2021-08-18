using module "./Test-Root.ps1"
using module "./Install-DnfPackage.ps1"

function Add-VirtualboxSignedModulesToLinuxKernel {

    param(
        [Parameter(Mandatory = $false)] $pathPublicKey = "/root/signed-modules/MOK.der" ,
        [Parameter(Mandatory = $false)] $pathPrivateKey = "/root/signed-modules/MOK.priv"
    )

    if (-not (Test-Root)) {
        throw "Not root"
    }

    $vboxdrv = Get-Item -Path (Invoke-Expression -Command "modinfo -n vboxdrv")
    $vboxdrvParentFolder = Get-ChildItem $vboxdrv.Directory
    $modFiles = $vboxdrvParentFolder.Where{
        $_.Extension -eq ".ko"
    }

    $uname = Invoke-Expression -Command "uname -r"
    $signFilePath = "/usr/src/kernels/$uname/scripts/sign-file"

    foreach ($modFile in $modFiles) {
        Invoke-Expression "$signFilePath sha256 $pathPrivateKey $pathPublicKey $($modFile.FullName)"
    }


    $unameR = Invoke-Expression -Command "uname -r"
    Install-DnfPackage -package "akmod-VirtualBox", "kernel-devel-$unameR"

    Invoke-Expression -Command "akmods"

    Invoke-Expression -Command "systemctl restart vboxdrv.service"

}