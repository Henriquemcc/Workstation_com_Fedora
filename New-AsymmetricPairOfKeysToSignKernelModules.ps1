using module "./Dnf.psm1"
function New-AsymmetricPairOfKeysToSignKernelModules
{
    <#
    .SYNOPSIS
        Generates a new pair of assimetric keys.
    .DESCRIPTION
        This function generates a new pair of assimetric key, and add it to the UEFI.
    #>
    Update-DnfPackages
    Install-DnfPackage -Package @("mokutil", "openssl")

    $pathSignedModulesFolder = "/root/signed-modules"

    # Criando a pasta onde será armazenada os módulos
    New-Item -Path $pathSignedModulesFolder -ItemType Directory -ErrorAction Ignore

    $pathMokPriv = Join-Path -Path $pathSignedModulesFolder -ChildPath "MOK.priv"

    $pathMokDer = Join-Path -Path $pathSignedModulesFolder -ChildPath "MOK.der"

    Invoke-Expression -Command "sudo openssl req -new -x509 -newkey rsa:2048 -keyout $pathMokPriv -outform DER -out $pathMokDer -nodes -days 36500 -subj ""/CN=VirtualBox/"""

    Invoke-Expression -Command "sudo chmod 600 $pathMokPriv"

    Invoke-Expression -Command "sudo mokutil --import $pathMokDer"

    return $pathMokDer, $pathMokPriv
}