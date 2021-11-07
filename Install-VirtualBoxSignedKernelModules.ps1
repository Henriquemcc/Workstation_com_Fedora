<#
.SYNOPSIS
    Signs and adds VirtualBox kernel modules.
.DESCRIPTION
    Signs and adds VirtualBox kernel modules so that it can run with UEFI and Secure Boot.
.PARAMETER PathPublicKey
    The path to the public key file.
.PARAMETER PathPrivateKey
    The path to the private key file.
#>

# Setting path of public and private keys
$PathPublicKey = "/root/signed-modules/MOK.der"
$PathPrivateKey = "/root/signed-modules/MOK.priv"

# Installing requirements
./Install-DnfPackage.ps1 -Package @("kmod", "coreutils")

# Generating pair of keys if they do not exist
$publicKeyFileExists = Test-Path -Path $PathPublicKey -Type Leaf
$privateKeyFileExists = Test-Path -Path $PathPrivateKey -Type Leaf
if ((-not$publicKeyFileExists) -or (-not$privateKeyFileExists)) {
    $PathPublicKey, $PathPrivateKey = ./New-AsymmetricPairOfKeysToSignKernelModules.ps1
}

# Getting information about VirtualBox module for Linux kernel
$vboxdrv = Get-Item -Path (Invoke-Expression -Command "modinfo -n vboxdrv")
$vboxdrvParentFolder = Get-ChildItem $vboxdrv.Directory
$modFiles = $vboxdrvParentFolder.Where{
    $_.Extension -eq ".ko"
}

# Getting the location of sign-file executable
$uname = Invoke-Expression -Command "uname -r"
$signFilePath = "/usr/src/kernels/$uname/scripts/sign-file"

# Singing kernel modules
foreach ($modFile in $modFiles) {
    Invoke-Expression "sudo $signFilePath sha256 $PathPrivateKey $PathPublicKey $( $modFile.FullName )"
}

# Installing kernel module and the requirements to build it
./Install-DnfPackage.ps1 -Package @("akmod-VirtualBox", "kernel-devel", "akmods")

# Checing the akmod packages and rebuilding them if needed
Invoke-Expression -Command "sudo akmods"

# Restarting VirtualBox service
Invoke-Expression -Command "sudo systemctl restart vboxdrv.service"