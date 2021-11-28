using module "./MenuOption.psm1"

$opcoes = @(
    [MenuOption]::new("Docker Engine", {
            ./Install-DockerEngine.ps1
        }),
    [MenuOption]::new("Driver Nvidia", {
            sudo pwsh InstalarDriverNvidia.ps1
        }),
    [MenuOption]::new("FlatHub", {
            ./Install-FlatHub.ps1
        }),
    [MenuOption]::new("Flatpak", {
            ./Install-Flatpak.ps1
        }),
    [MenuOption]::new("GitHub Cli", {
            Invoke-Expression -Command "bash ./Install-GithubCli.sh"
        }),
    [MenuOption]::new("Git Repo", {
            ./Install-GitRepo.ps1
        }),
    [MenuOption]::new("Google Chrome Stable", {
            ./Install-GoogleChromeStable.ps1
        }),
    [MenuOption]::new("Google Chrome Beta", {
            ./Install-GoogleChromeBeta.ps1
        }),
    [MenuOption]::new("Google Earth", {
            ./Install-GoogleEarth.ps1
        }),
    [MenuOption]::new("Gradle", {
            ./Install-Gradle.ps1
        }),
    [MenuOption]::new("Microsoft Teams", {
            ./Install-MicrosoftTeams.ps1
        }),
    [MenuOption]::new("MySQL WorkBench", {
            ./Install-MySQLWorkBench.ps1
        }),
    [MenuOption]::new("Peazip", {
            ./Install-Peazip.ps1
        }),
    [MenuOption]::new("Proton VPN", {
            ./Install-ProtonVPN.ps1
        }),
    [MenuOption]::new("Python 3 Pip", {
            ./Install-Python3Pip.ps1
        }),
    [MenuOption]::new("R Studio", {
            ./Install-RStudio.ps1
        }),
    [MenuOption]::new("Rust Programming Language", {
            ./Install-RustLang.ps1
        }),
    [MenuOption]::new("SDK Man", {
            Import-Module -Name "./Install-SdkMan.ps1"
            ./Install-SdkMan.ps1
        }),
    [MenuOption]::new("Snapd", {
            ./Install-Snapd.ps1
        }),
    [MenuOption]::new("VirtualBox", {
            sudo pwsh InstalarVirtualBox.ps1
        }),
    [MenuOption]::new("Visual Studio Code", {
            Invoke-Expression -Command "bash ./Install-VisualStudioCode.sh"
        })
)

function ObterOpcao {
    $mensagemOpcoes = ""
    $mensagemOpcoes += "O que deseja fazer?`n"
    $mensagemOpcoes += "0 - Sair`n"
    $mensagemOpcoes += "Instalar:`n"
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