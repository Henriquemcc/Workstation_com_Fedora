using module "./Install-DnfPackage.ps1"

function New-AsymmetricPairOfKeysToSignKernelModules
{
    <#
    .SYNOPSIS
        Generates a new pair of assimetric keys.
    .DESCRIPTION
        This function generates a new pair of assimetric key, and add it to the UEFI.
    #>

    # Installing requirements
    Update-DnfPackages
    Install-DnfPackage -Package @("mokutil", "openssl")

    # Creating folder where will be stored modules
    $pathSignedModulesFolder = "/root/signed-modules"
    $signedModulesFolderExists = Test-Path -Path $pathSignedModulesFolder -Type Container
    if (-not$signedModulesFolderExists)
    {
        New-Item -Path $pathSignedModulesFolder -ItemType Directory -ErrorAction Ignore
    }

    # Defining the path of public and private keys
    $pathPrivateKey = Join-Path -Path $pathSignedModulesFolder -ChildPath "MOK.priv"
    $pathPublicKey = Join-Path -Path $pathSignedModulesFolder -ChildPath "MOK.der"

    # Creating the pair of keys
    Invoke-Expression -Command "sudo openssl req -new -x509 -newkey rsa:2048 -keyout $pathPrivateKey -outform DER -out $pathPublicKey -nodes -days 36500 -subj ""/CN=VirtualBox/"""

    # Changing private key permissions
    Invoke-Expression -Command "sudo chmod 600 $pathPrivateKey"

    # Importing public key
    Invoke-Expression -Command "sudo mokutil --import $pathPublicKey"

    return $pathPublicKey, $pathPrivateKey
}