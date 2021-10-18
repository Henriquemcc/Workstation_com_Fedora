using module "./Read-Int32.ps1"
using module "./MenuOption.psm1"
using module "./Install-NvidiaDriver.ps1"

$opcoes = @(
[MenuOption]::new("Instalar driver Nvidia", {
    Install-NvidiaDriver
}),
[MenuOption]::new("Instalar driver Nvidia com compatibilidade com o Secure-Boot", {
    Install-NvidiaDriver -SignLinuxKernelModules
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