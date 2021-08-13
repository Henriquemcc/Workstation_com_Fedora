using module "./Test-Root.ps1"

function Add-VirtualboxSignedModulesToLinuxKernel {

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

    $pathModPriv = "/root/signed-modules/MOK.priv"
    $pathModDer = "/root/signed-modules/MOK.der"

    foreach ($modFile in $modFiles) {
        Invoke-Expression "$signFilePath sha256 $pathModPriv $pathModDer $($modFile.FullName)"
    }

}