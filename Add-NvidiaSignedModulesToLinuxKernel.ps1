using module "./Test-Root.ps1"

function Add-NvidiaSignedModulesToLinuxKernel {

    param(
        [Parameter(Mandatory = $false)] $pathPublicKey = "/root/signed-modules/MOK.der" ,
        [Parameter(Mandatory = $false)] $pathPrivateKey = "/root/signed-modules/MOK.priv"
    )

    if (-not (Test-Root)) {
        throw "Not root"
    }

    $nvidia = Get-Item -Path (Invoke-Expression -Command "modinfo -n nvidia")
    $nvidiaParentFolder = Get-ChildItem $nvidia.Directory
    $modFiles = $nvidiaParentFolder.Where{
        $_.Extension -eq ".ko"
    }

    $uname = Invoke-Expression -Command "uname -r"
    $signFilePath = "/usr/src/kernels/$uname/scripts/sign-file"

    foreach ($modFile in $modFiles) {
        Invoke-Expression "$signFilePath sha256 $pathPrivateKey $pathPublicKey $($modFile.FullName)"
    }

}