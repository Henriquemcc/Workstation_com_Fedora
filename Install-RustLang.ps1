function Install-RustLang
{
    Invoke-Expression -Command "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    Invoke-Expression -Command "source $HOME/.cargo/env"
}