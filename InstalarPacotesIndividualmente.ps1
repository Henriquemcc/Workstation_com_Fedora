using module "./Read-Int32.ps1"
using module "./Option.ps1"

$opcoes = @(
[Option]::new("Docker Engine", {
    Import-Module -Name "./Install-DockerEngine.ps1"
    Install-DockerEngine
}),
[Option]::new("FlatHub", {
    Import-Module -Name "./Install-FlatHub.ps1"
    Install-FlatHub
}),
[Option]::new("Flatpak", {
    Import-Module -Name "./Install-Flatpak.ps1"
    Install-Flatpak
}),
[Option]::new("GitHub Cli", {
    Import-Module -Name "./Install-GitHubCli.ps1"
    Install-GitHubCli
}),
[Option]::new("Google Chrome Stable", {
    Import-Module -Name "./Install-GoogleChromeStable.ps1"
    Install-GoogleChromeStable
}),
[Option]::new("Gradle", {
    Import-Module -Name "./Install-Gradle.ps1"
    Install-Gradle
}),
[Option]::new("Microsoft Teams", {
    Import-Module -Name "./Install-MicrosoftTeams.ps1"
    Install-MicrosoftTeams
}),
[Option]::new("MySQL WorkBench", {
    Import-Module -Name "./Install-MySQLWorkBench.ps1"
    Install-MySQLWorkBench
}),
[Option]::new("Peazip", {
    Import-Module -Name "./Install-Peazip.ps1"
    Install-Peazip
}),
[Option]::new("Proton VPN", {
    Import-Module -Name "./Install-ProtonVPN.ps1"
    Install-ProtonVPN
}),
[Option]::new("Python 3 Pip", {
    Import-Module -Name "./Install-Python3Pip.ps1"
    Install-Python3Pip
}),
[Option]::new("R Studio", {
    Import-Module -Name "./Install-RStudio.ps1"
    Install-RStudio
}),
[Option]::new("Rust Programming Language", {
    Import-Module -Name "./Install-RustLang.ps1"
    Install-RustLang
}),
[Option]::new("SDK Man", {
    Import-Module -Name "./Install-SdkMan.ps1"
    Install-SdkMan
}),
[Option]::new("Snapd", {
    Import-Module -Name "./Install-Snapd.ps1"
    Install-Snapd
}),
[Option]::new("Visual Studio Code", {
    Import-Module -Name "./Install-VisualStudioCode.ps1"
    Install-VisualStudioCode
})
)

function ObterOpcao
{
    $mensagemOpcoes = ""
    $mensagemOpcoes += "O que deseja fazer?`n"
    $mensagemOpcoes += "0 - Sair`n"
    $mensagemOpcoes += "Instalar:`n"
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