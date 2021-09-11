using module "./Python3Pip.psm1"
using module "./VisualStudioCode.psm1"
using module "./Install-Gradle.ps1"
using module "./Install-RustLang.ps1"

function InstalarPacotesPython3Pip
{
    <#
    .SYNOPSIS
        Instala os pacotes Python 3 Pip.
    .DESCRIPTION
        Esta função realiza a instalação dos pacotes Python 3 Pip que utilizo em minha máquina com o sistema operacional Fedora.
    #>

    # Instalando o Pip do Python 3
    Install-Python3Pip

    # Instalando os pacotes Pip
    Install-Python3PipPackage -Package "protonvpn-cli"
}

function ConfigurarGnomeShell
{

    <#
    .SYNOPSIS
        Configura e personaliza o Gnome Shell.
    .DESCRIPTION
        Esta função realiza a configuração e a personalização do Gnome Shell.
    #>

    # Desabilitando hot corners
    gsettings set org.gnome.desktop.interface enable-hot-corners false

    # Mostrar segundos
    gsettings set org.gnome.desktop.interface clock-show-seconds true

    # Mostrar dia da semana
    gsettings set org.gnome.desktop.interface clock-show-weekday true

    # Mostrar porcentagem da bateria
    gsettings set org.gnome.desktop.interface show-battery-percentage true

    # Habilitar atualização de fuso horário
    gsettings set org.gnome.desktop.datetime automatic-timezone true

    # Desabilitar autorun
    gsettings set org.gnome.desktop.media-handling autorun-never true

    # Habilitando botões minimizar e maximizar
    gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"
}

function InstalarExtensoesVisualStudioCode
{

    <#
    .SYNOPSIS
        Instala as extensões do Visual Studio Code.
    .DESCRIPTION
        Esta função instala as extensões que utilizo no Visual Studio Code.
    #>

    Install-VisualStudioCode

    $extensoes = @(
    # Tradução do VS Code em Português
    "ms-ceintl.vscode-language-pack-pt-br",

    # Linguagem C/C++
    "ms-vscode.cpptools",
    "ms-vscode.cmake-Tools",
    "austin.code-gnu-global",

    # Linguagem C#
    "ms-dotnettools.csharp",

    # Linguagem Java
    "vscjava.vscode-java-debug",
    "vscjava.vscode-maven",
    "vscjava.vscode-java-dependency",
    "vscjava.vscode-java-pack",
    "vscjava.vscode-java-test",
    "redhat.java",

    # Linguagem Rust
    "matklad.rust-analyzer",
    "vadimcn.vscode-lldb",
    "rust-lang.rust",

    # Linguagem Go
    "golang.Go",

    # HTML, CSS e Javascript
    "ecmel.vscode-html-css",
    "firefox-devtools.vscode-firefox-debug",
    "msjsdiag.debugger-for-chrome",
    "dbaeumer.vscode-eslint",

    # Tema do VS Code
    "GitHub.github-vscode-theme",

    # Markdown
    "DavidAnson.vscode-markdownlint",

    # Powershell
    " ms-vscode.PowerShell",

    # Indentação de código
    "NathanRidley.autotrim",
    "esbenp.prettier-vscode",

    # AI-assisted IntelliSense
    "VisualStudioExptTeam.vscodeintellicode"
    )

    Install-VisualStudioCodeExtension -Extension $extensoes
}

function ConfigurarPastaBin
{
    <#
    .SYNOPSIS
        Configura a pasta ~/bin.
    .DESCRIPTION
        Esta função configura a pasta bin que está dentro do diretório do usuário, contendo arquivos binários.
    #>

    # Adicionando a pasta ~/bin ao path do sistema
    $bashDotRc = [System.IO.File]::AppendText("$( $env:HOME )/.bashrc")
    $bashDotRc.WriteLine("export PATH=""$HOME/bin:$`PATH""")

    # Criando link do adb na pasta ~/bin
    $pathAdb = "$( $env:HOME )/Android/Sdk/platform-tools/adb"
    if (Test-Path -Path $pathAdb)
    {
        New-Item -Path "$( $env:HOME )/bin/adb" -ItemType SymbolicLink -Target $pathAdb
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

    InstalarPacotesPython3Pip
    ConfigurarGnomeShell
    ConfigurarPastaBin
    InstalarExtensoesVisualStudioCode
    Install-Gradle
    Install-RustLang
}

Main
