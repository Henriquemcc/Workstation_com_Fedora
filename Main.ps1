using module "./Write-Title.ps1"
using module "./MyIO.psm1"

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
            Invoke-Expression -Command "pwsh ./InstalarProgramas.ps1"
        }
        elseif ($opcaoSelecionada -eq 2) {
            Invoke-Expression -Command "sudo pwsh ./AtualizarPacotes.ps1"
        }
        elseif ($opcaoSelecionada -eq 3) {
            Invoke-Expression -Command "sudo pwsh ./GerarChavesEAdicionarAUEFI.ps1"
        }
        elseif ($opcaoSelecionada -eq 4) {
            Invoke-Expression -Command "sudo pwsh ./AdicionarModulosNvidiaAoKernelLinux.ps1"
        }
        elseif ($opcaoSelecionada -eq 5) {
            Invoke-Expression -Command "sudo pwsh ./AdicionarModulosVirtualboxAoKernelLinux.ps1"
        }
    }
}

function Main {

    Write-Title "Workstation com Fedora"
    Write-Host
    Menu
}

Main