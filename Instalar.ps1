function Instalar
{
    <#
    .SYNOPSIS
        Inicia o processo de instalação dos programas.
    .DESCRIPTION
        Esta função inicia o processo de instalação dos programas que utilizo em minha máquina com o sistema operacional Fedora.
    .EXAMPLE
        PS /> Instalar
        Este exemplo inicia o processo de instalação dos programas que utilizo em minha máquina com o sistema operacional Fedora.
    #>
    Invoke-Expression -Command "sudo pwsh ""./InstalarRoot.ps1"""
    Invoke-Expression -Command "pwsh ""./InstalarUsuario.ps1"""
}
