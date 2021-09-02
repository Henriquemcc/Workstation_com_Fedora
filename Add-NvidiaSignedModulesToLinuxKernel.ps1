function Add-NvidiaSignedModulesToLinuxKernel
{
    param(
        [Parameter(Mandatory = $false)] $PathPublicKey = "/root/signed-modules/MOK.der",
        [Parameter(Mandatory = $false)] $PathPrivateKey = "/root/signed-modules/MOK.priv"
    )

    <#
    .SYNOPSIS
        Signs and adds Nvidia kernel modules.
    .DESCRIPTION
        This function signs and adds Nvidia kernel modules so that it can run with UEFI and Secure Boot.
    .PARAMETER PathPublicKey
        The path to the public key file.
    .PARAMETER PathPrivateKey
        The path to the private key file.
    #>

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