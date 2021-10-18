using module "./MenuOption.psm1"
using module "./Install-NvidiaSignedKernelModules.ps1"
using module "./Install-VirtualBoxSignedKernelModules.ps1"
using module "./Read-Int32.ps1"

$opcoes = @(

[MenuOption]::new("Adicionar módulos do driver da NVIDIA ao Kernel Linux", {
    Install-NvidiaSignedKernelModules
}),
[MenuOption]::new("Adicionar módulos do VirtualBox ao Kernel Linux", {
    Install-VirtualBoxSignedKernelModules
})
)

function ObterOpcao
{
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
    while (($null -eq $opcaoSelecionada) -or ($opcaoSelecionada -lt 0) -or ($opcaoSelecionada -gt $opcoes.Length))
    {
        $opcaoSelecionada = Read-Int32 -Prompt $mensagemOpcoes
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

Menu