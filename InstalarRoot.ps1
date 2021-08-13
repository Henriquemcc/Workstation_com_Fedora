#!/bin/pwsh

using module "./Dnf.psm1"
using module "./Snap.psm1"
using module "./Flatpak.psm1"
using module "./Wifi.psm1"

function InstalarPacotesDnf {
    Enable-RpmFusion
    Update-DnfPackages

    $packages = @(
        # Programas externos
        #   Google Chrome
        "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm",

        #   Peazip
        "https://github.com/peazip/PeaZip/releases/download/8.1.0/peazip-8.1.0.LINUX.GTK2-1.x86_64.rpm",

        # R Studio
        "https://download1.rstudio.org/desktop/centos8/x86_64/rstudio-1.4.1717-x86_64.rpm",

        # Nvidia
        "akmod-nvidia",

        # Libreoffice
        "libreoffice-writer", "libreoffice-calc", "libreoffice-impress", "libreoffice-math", "libreoffice-draw",
        "libreoffice-langpack-pt-BR", "libreoffice-langpack-en", "unoconv",

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

    Install-DnfPackage -package $packages
    Update-DnfPackages
}

function InstalarPacotesSnap {

    Install-Snapd
    Install-SnapPackage -package "keepassxc" -devmode
    Install-SnapPackage -package "spotify"
    Install-SnapPackage -package "code" -classic
    Install-SnapPackage -package "intellij-idea-community" -classic
    Install-SnapPackage -package "pycharm-community" -classic
    Install-SnapPackage -package "flutter" -classic
    Install-SnapPackage -package "kotlin" -classic
    Install-SnapPackage -package "skype" -classic
    Update-SnapPackages
}

function InstalarPacotesFlatpak {
    Install-FlatHub

    $pacotes = @(
        "https://dl.flathub.org/repo/appstream/com.google.AndroidStudio.flatpakref",
        "https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref",
        "https://dl.flathub.org/repo/appstream/org.audacityteam.Audacity.flatpakref",
        "https://dl.flathub.org/repo/appstream/org.signal.Signal.flatpakref"
    )
    Install-FlatpakPackage -package $pacotes
    Update-FlatpackPackages
}

function InstalarPacotesPython3Pip {
    Install-Python3Pip -package "protonvpn-cli"
}

function Main {
    InstalarPacotesDnf
    InstalarPacotesSnap
    InstalarPacotesFlatpak
    InstalarPacotesPython3Pip
}

Main