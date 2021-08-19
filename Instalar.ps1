using module "./Dnf.psm1"
using module "./Snap.psm1"
using module "./Flatpak.psm1"
using module "./Install-SignedKernelModules.ps1"
using module "./VisualStudioCode.psm1"
using module "./Install-RustLang.ps1"

function InstalarPacotesDnf
{
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
    # Instalando o FlatHub
    Install-FlatHub

    # Instalando os pacotes FlatPak
    $pacotes = @(
    "https://dl.flathub.org/repo/appstream/com.google.AndroidStudio.flatpakref",
    "https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref",
    "https://dl.flathub.org/repo/appstream/org.audacityteam.Audacity.flatpakref",
    "https://dl.flathub.org/repo/appstream/org.signal.Signal.flatpakref"
    )
    Install-FlatpakPackage -Package $pacotes

    # Atualizando os pacotes FlatPak
    Update-FlatpackPackages
}

function InstalarPacotesPython3Pip
{
    # Instalando o Pip do Python 3
    Install-Python3Pip

    # Instalando os pacotes Pip
    Install-Python3PipPackage -Package "protonvpn-cli"
}

function ConfigurarVirtualbox
{
    Install-SignedKernelModules
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

function Instalar
{
    InstalarPacotesDnf
    InstalarPacotesSnap
    InstalarPacotesFlatpak
    InstalarPacotesPython3Pip
    ConfigurarVirtualbox
    ConfigurarGnomeShell
    InstalarExtensoesVisualStudioCode
    Install-RustLang
}