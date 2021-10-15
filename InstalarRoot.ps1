using module "./Dnf.psm1"
using module "./Snap.psm1"
using module "./Flatpak.psm1"
using module "./Install-SignedKernelModules.ps1"
using module "./New-Shortcut.ps1"
using module "./Install-DockerEngine.ps1"
using module "./Install-GoogleChromeStable.ps1"
using module "./Install-GitHubCli.ps1"
using module "./Install-MicrosoftTeams.ps1"
using module "./Install-MySQLWorkBench.ps1"
using module "./Install-Peazip.ps1"
using module "./Install-ProtonVPN.ps1"
using module "./Install-RStudio.ps1"

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

    # Instalando os pacotes DNF
    $packages = @(

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
    "aspnetcore-runtime-5.0", "dotnet-runtime-5.0", "git", "git-lfs", "android-tools",

    # Outros programas
    "stacer", "qt5-qtcharts", "vlc", "qt5-qtsvg", "youtube-dl", "snapd", "flatpak", "transmission",
    "ffmpeg", "steam", "VirtualBox", "mokutil", "fdupes", "dnf-automatic", "gnome-tweaks", "dconf-editor", "audacity",

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
    $pacotes = @()
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
    Install-GitHubCli
    Install-GoogleChromeStable
    # Install-MicrosoftTeams
    Install-MySQLWorkBench
    Install-Peazip
    Install-ProtonVPN
    # Install-RStudio
    InstalarPacotesSnap
    InstalarPacotesFlatpak
    Install-SignedKernelModules
    Install-DockerEngine
    ConfigurarJava
    
}

Main
