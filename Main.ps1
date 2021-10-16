using module "./Write-Title.ps1"
using module "./Update-Packages.ps1"
using module "./MenuOption.psm1"
using module "./Read-Byte.ps1"

$opcoes = @(
[MenuOption]::new("Executar instalação padrão", {
    ./Instalar.ps1
}),
[MenuOption]::new("Atualizar todos os pacotes", {
    Update-Packages
}),
[MenuOption]::new("Configurar módulos do kernel", {
    ./ConfigurarModulosKernelLinux.ps1
}),
[MenuOption]::new("Instalar pacotes individualmente", {
    ./InstalarPacotesIndividualmente.ps1
})
)

function ObterOpcao
{

    <#
    .SYNOPSIS
        Obtém da entrada padrão a opção que o usuário deseja executar.
    .DESCRIPTION
        Esta funcção obtém do usuário qual opção ele deseja realizar.
    #>

    $mensagemOpcoes = ""
    $mensagemOpcoes += "O que deseja fazer?`n"
    $mensagemOpcoes += "0 - Sair`n"

    $index = 0
    foreach ($opcao in $opcoes)
    {
        $index++
        $mensagemOpcoes += "$index - $( $opcao.Name )`n"
    }

    $opcaoSelecionada = $null
    while (($null -eq $opcaoSelecionada) -or ($opcaoSelecionada -lt 0) -or ($opcaoSelecionada -gt 6))
    {
        $opcaoSelecionada = Read-Byte -Prompt $mensagemOpcoes
    }

    return $opcaoSelecionada
}

function Menu
{

    $opcaoSelecionada = $null

    while ($opcaoSelecionada -ne 0)
    {
        $opcaoSelecionada = ObterOpcao
        if ($opcaoSelecionada -ne 0)
        {
            Invoke-Command -ScriptBlock $opcoes.Get(($opcaoSelecionada - 1)).Script
        }
    }

}

function Main
{
    <#
    .SYNOPSIS
        Função principal.
    .DESCRIPTION
        Esta é a função principal deste script.
    #>

    Write-Title "Workstation com Fedora"
    Write-Host
    Menu
}

Main