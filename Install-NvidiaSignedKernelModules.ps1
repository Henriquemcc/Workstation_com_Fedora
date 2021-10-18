function Install-NvidiaSignedKernelModules
{
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

    # Defining the path of public and private keys
    $PathPublicKey = "/root/signed-modules/MOK.der"
    $PathPrivateKey = "/root/signed-modules/MOK.priv"

    # Installing requirements
    Install-DnfPackage -Package @("kmod", "coreutils")

    # Generating pair of keys if they do not exist
    $publicKeyFileExists = Test-Path -Path $PathPublicKey -Type Leaf
    $privateKeyFileExists = Test-Path -Path $PathPrivateKey -Type Leaf
    if ((-not$publicKeyFileExists) -or (-not$privateKeyFileExists))
    {
        Import-Module -Name "./New-AsymmetricPairOfKeysToSignKernelModules.ps1"
        $PathPublicKey, $PathPrivateKey = New-AsymmetricPairOfKeysToSignKernelModules
    }

    # Getting information about Nvidia module for Linux kernel
    $nvidia = Get-Item -Path (Invoke-Expression -Command "modinfo -n nvidia")
    $nvidiaParentFolder = Get-ChildItem $nvidia.Directory
    $modFiles = $nvidiaParentFolder.Where{
        $_.Extension -eq ".ko"
    }

    # Getting the location of sign-file executable
    $uname = Invoke-Expression -Command "uname -r"
    $signFilePath = "/usr/src/kernels/$uname/scripts/sign-file"

    # Signing kernel modules
    foreach ($modFile in $modFiles)
    {
        Invoke-Expression "sudo $signFilePath sha256 $PathPrivateKey $PathPublicKey $( $modFile.FullName )"
    }

}