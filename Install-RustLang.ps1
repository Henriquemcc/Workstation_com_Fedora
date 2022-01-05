<#
.SYNOPSIS
    Installs Rust programming language.
.DESCRIPTION
    This installs Rust programming language using Rustup.
#>

./Install-DnfPackage.ps1 -Package "curl"
Invoke-Expression -Command "bash Install-RustLang.sh"