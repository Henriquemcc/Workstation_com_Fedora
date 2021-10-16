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
    $pacotes = $( )
    Install-Python3PipPackage -Package $pacotes
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

    # Habilitando icones na área de trabalho
    gsettings set org.gnome.desktop.background show-desktop-icons true

    # Habilitando localização automatica gnome shell weather
    gsettings set org.gnome.shell.weather automatic-location true

    # Habilitando o Fractional scaling
    gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
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
    Install-Gradle
    Install-RustLang
}

Main
