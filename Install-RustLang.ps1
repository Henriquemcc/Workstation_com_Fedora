function Install-RustLang
{
    <#
    .SYNOPSIS
        Installs Rust programming language.
    .DESCRIPTION
        This function installs Rust programming language using Rustup.
    #>

    Invoke-Expression -Command "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    Invoke-Expression -Command "source $HOME/.cargo/env"
}