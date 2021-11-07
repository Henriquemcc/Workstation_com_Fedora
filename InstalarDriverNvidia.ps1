using module "./MenuOption.psm1"

$opcoes = @(
    [MenuOption]::new("Instalar driver Nvidia", {
            ./Install-NvidiaDriver.ps1
        }),
    [MenuOption]::new("Instalar driver Nvidia com compatibilidade com o Secure-Boot", {
            ./Install-NvidiaDriver.ps1 -SignLinuxKernelModules
        })
)

function ObterOpcao {
    $mensagemOpcoes = ""
    $mensagemOpcoes += "O que deseja fazer?`n"
    $mensagemOpcoes += "0 - Sair`n"
    $index = 0
    foreach ($opcao in $opcoes) {
        $index++
        $mensagemOpcoes += "$index - $( $opcao.Name )`n"
    }

    $opcaoSelecionada = $null
    while (($null -eq $opcaoSelecionada) -or ($opcaoSelecionada -lt 0) -or ($opcaoSelecionada -gt $opcoes.Length)) {
        $opcaoSelecionada = ./Read-Int32.ps1 -Prompt $mensagemOpcoes
    }

    return $opcaoSelecionada
}

$opcaoSelecionada = $null

while ($opcaoSelecionada -ne 0) {
    $opcaoSelecionada = ObterOpcao
    if ($opcaoSelecionada -ne 0) {
        Invoke-Command -ScriptBlock $opcoes.Get(($opcaoSelecionada - 1)).Script
    }
}