using module "./Install-DnfPackage.ps1"
function Install-RustLang
{
    <#
    .SYNOPSIS
        Installs Rust programming language.
    .DESCRIPTION
        This function installs Rust programming language using Rustup.
    #>

    Install-DnfPackage -Package "curl"
    Invoke-Expression -Command "bash Install-RustLang.sh"
}