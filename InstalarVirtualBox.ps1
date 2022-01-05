using module "./Read-Int32.ps1"
using module "./MenuOption.psm1"

$secureBoot = $false
$extensionPack = $false

function ObterOpcao {
    $mensagemOpcoes = ""
    $mensagemOpcoes += "O que deseja fazer?`n"
    $mensagemOpcoes += "0 - Sair`n"
    $mensagemOpcoes += "1 - Instalar VirtualBox`n"
    $mensagemOpcoes += "2 - Compatibilidade com Secure-Boot: "

    if ($secureBoot) {
        $mensagemOpcoes += "Habilitado"
    }
    else {
        $mensagemOpcoes += "Desabilitado"
    }
    $mensagemOpcoes += "`n"

    $mensagemOpcoes += "3 - Pacote de extensão: "
    if ($extensionPack) {
        $mensagemOpcoes += "Habilitado"
    }
    else {
        $mensagemOpcoes += "Desabilitado"
    }
    $mensagemOpcoes += "`n"

    $opcaoSelecionada = $null
    while (($null -eq $opcaoSelecionada) -or ($opcaoSelecionada -lt 0) -or ($opcaoSelecionada -gt 3)) {
        $opcaoSelecionada = Read-Int32 -Prompt $mensagemOpcoes
    }

    return $opcaoSelecionada
}

$opcaoSelecionada = $null

while ($opcaoSelecionada -ne 0) {
    $opcaoSelecionada = ObterOpcao
    if ($opcaoSelecionada -ne 0) {
        if ($opcaoSelecionada -eq 1) {
            ./Install-VirtualBox.ps1 -InstallExtensionPack:$extensionPack -SignLinuxKernelModules:$secureBoot
        }
        elseif ($opcaoSelecionada -eq 2) {
            $secureBoot = (-not$secureBoot)
        }
        elseif ($opcaoSelecionada -eq 3) {
            $extensionPack = (-not$extensionPack)
        }
    }
}