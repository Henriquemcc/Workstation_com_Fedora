function InstalarPacotesDnf {

    <#
    .SYNOPSIS
        Instala os pacotes DNF.
    .DESCRIPTION
        Esta função realiza a instalação dos pacotes DNF que utilizo em minha máquina com o sistema operacional Fedora.
    #>

    # Habilitando o RPM Fusion
    ./Enable-RpmFusion.ps1

    # Instalando os pacotes DNF
    $packages = @(

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
        "ffmpeg", "steam", "mokutil", "fdupes", "dnf-automatic", "gnome-tweaks", "dconf-editor", "audacity",

        # Reportar erro automaticamente
        "abrt-desktop", "abrt-java-connector"
    )
    ./Install-DnfPackage.ps1 -Package $packages

    # Atualizando pacotes DNF
    ./Update-DnfPackages.ps1
}

function InstalarPacotesSnap {

    <#
    .SYNOPSIS
        Instala os pacotes Snap.
    .DESCRIPTION
        Esta função realiza a instalação dos pacotes Snap que utilizo em minha máquina com o sistema operacional Fedora.
    #>

    # Instalando o Snapd
    ./Install-Snapd.ps1

    # Instalando pacotes snap
    ./Install-SnapPackage.ps1 -Package "spotify"
    ./Install-SnapPackage.ps1 -Package "intellij-idea-community" -classic
    ./Install-SnapPackage.ps1 -Package "pycharm-community" -classic
    ./Install-SnapPackage.ps1 -Package "flutter" -classic
    ./Install-SnapPackage.ps1 -Package "kotlin" -classic
    ./Install-SnapPackage.ps1 -Package "skype" -classic

    # Atualizando pacotes Snap
    ./Update-SnapPackages.ps1
}

function InstalarPacotesFlatpak {

    <#
    .SYNOPSIS
        Instala os pacotes Flatpak.
    .DESCRIPTION
        Esta função realiza a instalação dos pacotes Flatpak que utilizo em minha máquina com o sistema operacional Fedora.
    #>

    # Instalando o FlatHub
    ./Install-FlatHub.ps1

    # Instalando os pacotes FlatPak
    $pacotes = @()
    ./Install-FlatpakPackage.ps1 -Package $pacotes

    # Atualizando os pacotes FlatPak
    ./Update-FlatpackPackages.ps1
}

function ConfigurarJava {

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
    ./New-Shortcut.ps1 -Name "Java Runtime Environment 8" -GenericName "Java 8" -Keywords @("java", "runtime", "environment", "8", "jre") -Exec "java8 -jar %f" -Terminal $false -Type Application -MimeType @("application/x-java-archive") -StartupNotify $true -Icon "java-1.8.0-openjdk" -AllUsers -FileName "java8.desktop"

    #Criando o atalho para o Java
    ./New-Shortcut.ps1 -Name "Java Runtime Environment" -GenericName "Java" -Keywords @("java", "runtime", "environment", "jre") -Exec "java -jar %f" -Terminal $false -Type Application -MimeType @("application/x-java-archive") -StartupNotify $true -Icon "java-1.8.0-openjdk" -AllUsers -FileName "java.desktop"

}

# Instalando Visual Studio Code
Invoke-Expression -Command "bash ./Install-VisualStudioCode.sh"

# Instalando o driver Nvidia
./Install-NvidiaDriver.ps1 -SignLinuxKernelModules

# Instalando outros pacotes DNF
InstalarPacotesDnf

# Instalando GitHub Cli
./Install-GitHubCli.ps1

# Instalando Google Chrome
./Install-GoogleChromeStable.ps1

# Instalando VirtualBox
./Install-VirtualBox.ps1 -InstallExtensionPack -SignLinuxKernelModules

# Instalando MySQL WorkBench
./Install-MySQLWorkBench.ps1

# Instalando Peazip
./Install-Peazip.ps1

# Instalando Proton VPN
./Install-ProtonVPN.ps1

# Instalando pacotes Snap
InstalarPacotesSnap

# Instalando pacotes Flatpak
InstalarPacotesFlatpak

# Instalando Docker
./Install-DockerEngine.ps1

# Configurando o Java
ConfigurarJava