function Add-NvidiaSignedModulesToLinuxKernel
{

    param(
        [Parameter(Mandatory = $false)] $PathPublicKey = "/root/signed-modules/MOK.der",
        [Parameter(Mandatory = $false)] $PathPrivateKey = "/root/signed-modules/MOK.priv"
    )

    $nvidia = Get-Item -Path (Invoke-Expression -Command "modinfo -n nvidia")
    $nvidiaParentFolder = Get-ChildItem $nvidia.Directory
    $modFiles = $nvidiaParentFolder.Where{
        $_.Extension -eq ".ko"
    }

    $uname = Invoke-Expression -Command "uname -r"
    $signFilePath = "/usr/src/kernels/$uname/scripts/sign-file"

    foreach ($modFile in $modFiles)
    {
        Invoke-Expression "sudo $signFilePath sha256 $PathPrivateKey $PathPublicKey $( $modFile.FullName )"
    }

}