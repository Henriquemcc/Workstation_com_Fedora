using module "./Write-Title.ps1"
using module "./MyIO.psm1"
using module "./Instalar.ps1"
using module "./Update-Packages.ps1"
using module "./Install-SignedKernelModules.ps1"
using module "./Add-NvidiaSignedModulesToLinuxKernel.ps1"
using module "./Add-VirtualboxSignedModulesToLinuxKernel.ps1"

function ObterOpcao {

    $mensagemOpcoes = @"
O que deseja fazer?
0 - Sair
1 - Executar a instalação dos programas
2 - Atualizar todos os pacotes
3 - Gerar chaves publica e privada e adicionar á UEFI
4 - Adicionar módulos do driver da NVIDIA ao Kernel Linux
5 - Adicionar módulos do VirtualBox ao Kernel Linux
>
"@

    $opcaoSelecionada = $null
    while (($null -eq $opcaoSelecionada) -or ($opcaoSelecionada -lt 0) -or ($opcaoSelecionada -gt 5)) {
        $opcaoSelecionada = Read-Byte -Prompt $mensagemOpcoes
    }

    return $opcaoSelecionada
}

function Menu {

    $opcaoSelecionada = $null

    while ($opcaoSelecionada -ne 0) {

        $opcaoSelecionada = ObterOpcao

        if ($opcaoSelecionada -eq 1) {
            Instalar
        }
        elseif ($opcaoSelecionada -eq 2) {
            Update-Packages
        }
        elseif ($opcaoSelecionada -eq 3) {
            Install-SignedKernelModules
        }
        elseif ($opcaoSelecionada -eq 4) {
            Add-NvidiaSignedModulesToLinuxKernel
        }
        elseif ($opcaoSelecionada -eq 5) {
            Add-VirtualboxSignedModulesToLinuxKernel
        }
    }
}

function Main {

    Write-Title "Workstation com Fedora"
    Write-Host
    Menu
}

Main