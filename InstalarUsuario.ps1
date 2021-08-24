using module "./Python3Pip.psm1"
using module "./VisualStudioCode.psm1"

function InstalarPacotesPython3Pip
{
    # Instalando o Pip do Python 3
    Install-Python3Pip

    # Instalando os pacotes Pip
    Install-Python3PipPackage -Package "protonvpn-cli"
}

function ConfigurarGnomeShell
{
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
}

function InstalarExtensoesVisualStudioCode
{
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

function Main
{
    InstalarPacotesPython3Pip
    ConfigurarGnomeShell
    InstalarExtensoesVisualStudioCode
}

Main