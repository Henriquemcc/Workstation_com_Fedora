using module "./Install-DnfPackage.ps1"

function Add-VirtualboxSignedModulesToLinuxKernel
{
    param(
        [Parameter(Mandatory = $false)] $PathPublicKey = "/root/signed-modules/MOK.der",
        [Parameter(Mandatory = $false)] $PathPrivateKey = "/root/signed-modules/MOK.priv"
    )

    $vboxdrv = Get-Item -Path (Invoke-Expression -Command "modinfo -n vboxdrv")
    $vboxdrvParentFolder = Get-ChildItem $vboxdrv.Directory
    $modFiles = $vboxdrvParentFolder.Where{
        $_.Extension -eq ".ko"
    }

    $uname = Invoke-Expression -Command "uname -r"
    $signFilePath = "/usr/src/kernels/$uname/scripts/sign-file"

    foreach ($modFile in $modFiles)
    {
        Invoke-Expression "sudo $signFilePath sha256 $PathPrivateKey $PathPublicKey $( $modFile.FullName )"
    }

    Install-DnfPackage -Package @("akmod-VirtualBox", "kernel-devel")

    Invoke-Expression -Command "sudo akmods"

    Invoke-Expression -Command "sudo systemctl restart vboxdrv.service"
}