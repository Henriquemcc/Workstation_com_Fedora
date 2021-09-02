using module "./Dnf.psm1"
using module "./Snap.psm1"
using module "./Flatpak.psm1"
using module "./Install-SignedKernelModules.ps1"
using module "./New-Shortcut.ps1"

function InstalarPacotesDnf
{

    <#
    .SYNOPSIS
        Instala os pacotes DNF.
    .DESCRIPTION
        Esta função realiza a instalação dos pacotes DNF que utilizo em minha máquina com o sistema operacional Fedora.
    #>

    # Habilitando o RPM Fusion
    Enable-RpmFusion

    # Adicionando repositório do GitHub CLI
    Add-DnfRepository -Repository "https://cli.github.com/packages/rpm/gh-cli.repo"

    # Obtendo a Url do .RPM do Microsoft Teams
    $urlMicrosoftTeams = (Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/p/?LinkID=2112907&clcid=0x409&culture=en-us&country=US").BaseResponse.RequestMessage.RequestUri.AbsoluteUri

    # Instalando os pacotes DNF
    $packages = @(
    # Programas externos
    #   Google Chrome
    "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm",

    # Microsoft Teams
    $urlMicrosoftTeams,

    #   Peazip
    "https://github.com/peazip/PeaZip/releases/download/8.1.0/peazip-8.1.0.LINUX.GTK2-1.x86_64.rpm",

    # R Studio
    "https://download1.rstudio.org/desktop/centos8/x86_64/rstudio-1.4.1717-x86_64.rpm",

    # Nvidia
    "akmod-nvidia",

    # KeepassXC
    "keepassxc",

    # Libreoffice
    "libreoffice-writer", "libreoffice-calc", "libreoffice-impress", "libreoffice-math", "libreoffice-draw",
    "libreoffice-langpack-pt-BR", "libreoffice-langpack-en", "unoconv",

    # File Roller
    "file-roller", "file-roller-nautilus",

    # Impressora HP
    "hplip",

    # Driver da placa de som
    "alsa-firmware", "pipewire", "pipewire-pulseaudio",

    # Suporte a arquivos 7zip
    "p7zip-plugins", "p7zip",

    # KVM
    "qemu-kvm", "libvirt",

    # Sistemas de arquivos não nativos do linux
    "ntfs-3g", "exfat-utils", "fuse", "fuse-exfat",

    # Extensões do Gnome shell
    "gnome-shell-extension-updates-dialog", "gnome-shell-extension-dash-to-dock",

    # Ferramentas de desenvolvimento
    "java-latest-openjdk-devel", "java-1.8.0-openjdk-devel", "golang", "gcc", "dotnet-sdk-5.0",
    "aspnetcore-runtime-5.0", "dotnet-runtime-5.0", "git", "git-lfs", "gh", "R",

    # Outros programas
    "stacer", "qt5-qtcharts", "vlc", "qt5-qtsvg", "youtube-dl.noarch", "snapd", "flatpak", "transmission",
    "ffmpeg", "steam", "VirtualBox", "mokutil", "fdupes", "dnf-automatic", "gnome-tweaks", "dconf-editor",

    # Reportar erro automaticamente
    "abrt-desktop", "abrt-java-connector"
    )
    Install-DnfPackage -Package $packages

    # Atualizando pacotes DNF
    Update-DnfPackages
}

function InstalarPacotesSnap
{

    <#
    .SYNOPSIS
        Instala os pacotes Snap.
    .DESCRIPTION
        Esta função realiza a instalação dos pacotes Snap que utilizo em minha máquina com o sistema operacional Fedora.
    #>

    # Instalando o Snapd
    Install-Snapd

    # Instalando pacotes snap
    Install-SnapPackage -Package "spotify"
    Install-SnapPackage -Package "code" -classic
    Install-SnapPackage -Package "intellij-idea-community" -classic
    Install-SnapPackage -Package "pycharm-community" -classic
    Install-SnapPackage -Package "flutter" -classic
    Install-SnapPackage -Package "kotlin" -classic
    Install-SnapPackage -Package "skype" -classic

    # Atualizando pacotes Snap
    Update-SnapPackages
}

function InstalarPacotesFlatpak
{

    <#
    .SYNOPSIS
        Instala os pacotes Flatpak.
    .DESCRIPTION
        Esta função realiza a instalação dos pacotes Flatpak que utilizo em minha máquina com o sistema operacional Fedora.
    #>

    # Instalando o FlatHub
    Install-FlatHub

    # Instalando os pacotes FlatPak
    $pacotes = @(
    "https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref",
    "https://dl.flathub.org/repo/appstream/org.audacityteam.Audacity.flatpakref",
    "https://dl.flathub.org/repo/appstream/org.signal.Signal.flatpakref"
    )
    Install-FlatpakPackage -Package $pacotes

    # Atualizando os pacotes FlatPak
    Update-FlatpackPackages
}

function ConfigurarJava
{

    <#
    .SYNOPSIS
        Configura o Java.
    .DESCRIPTION
        Esta função configura o Java para que seja criado os comandos java8 e javac8 além da criação do atalho do Java Runtime Environment 8 e do Java Runtime Environment última versão.
    #>

    #Criando o comando Java8
    Invoke-Expression -Command "sudo ln --symbolic /usr/lib/jvm/java-1.8.0/bin/java /bin/java8"

    #Criando o comando Javac8
    Invoke-Expression -Command "sudo ln --symbolic /usr/lib/jvm/java-1.8.0/bin/javac /bin/javac8"

    #Criando o atalho para o Java 8
    New-Shortcut -Name "Java Runtime Environment 8" -GenericName "Java 8" -Keywords @("java", "runtime", "environment", "8", "jre") -Exec "java8 -jar %f" -Terminal $false -Type Application -MimeType @("application/x-java-archive") -StartupNotify $true -Icon "java-1.8.0-openjdk" -AllUsers -FileName "java8.desktop"

    #Criando o atalho para o Java
    New-Shortcut -Name "Java Runtime Environment" -GenericName "Java" -Keywords @("java", "runtime", "environment", "jre") -Exec "java -jar %f" -Terminal $false -Type Application -MimeType @("application/x-java-archive") -StartupNotify $true -Icon "java-1.8.0-openjdk" -AllUsers -FileName "java.desktop"

}

function Main
{

    <#
    .SYNOPSIS
        Função principal.
    .DESCRIPTION
        Esta é a função principal deste script.
    #>

    InstalarPacotesDnf
    InstalarPacotesSnap
    InstalarPacotesFlatpak
    Install-SignedKernelModules
    ConfigurarJava
}

Main