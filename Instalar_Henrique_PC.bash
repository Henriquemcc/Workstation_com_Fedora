#!/bin/bash

function run_as_root() {

  #  Instala script Update-All.sh
  function instalar_script_update_all() {
    sudo cp ./Update-All.sh /bin/Update-All.sh
    sudo chmod +x /bin/Update-All.sh
  }

  # Instala pacotes dnf
  function instalar_pacotes_dnf() {

    # Habilitando RPM Fusion
    bash ./Enable-RpmFusion.sh

    # Instalando o KeepassXC
    sudo dnf install --assumeyes keepassxc

    # Instalando o Libreoffice
    sudo dnf install --assumeyes libreoffice-writer
    sudo dnf install --assumeyes libreoffice-calc
    sudo dnf install --assumeyes libreoffice-impress
    sudo dnf install --assumeyes libreoffice-math
    sudo dnf install --assumeyes libreoffice-draw
    sudo dnf install --assumeyes libreoffice-langpack-pt-BR
    sudo dnf install --assumeyes libreoffice-langpack-en
    sudo dnf install --assumeyes unoconv

    # Instalando o File Roller
    sudo dnf install --assumeyes file-roller
    sudo dnf install --assumeyes file-roller-nautilus

    # Instalando a Impressora HP
    sudo dnf install --assumeyes hplip

    # Instalando o Driver da placa de som
    sudo dnf install --assumeyes alsa-firmware
    sudo dnf install --assumeyes pipewire
    sudo dnf install --assumeyes pipewire-pulseaudio

    # Instalando o Suporte a arquivos 7zip
    sudo dnf install --assumeyes p7zip-plugins
    sudo dnf install --assumeyes p7zip

    # Instalando o KVM
    sudo dnf install --assumeyes qemu-kvm
    sudo dnf install --assumeyes libvirt

    # Instalando os Sistemas de arquivos não nativos do linux
    sudo dnf install --assumeyes ntfs-3g
    sudo dnf install --assumeyes exfat-utils
    sudo dnf install --assumeyes fuse
    sudo dnf install --assumeyes fuse-exfat

    # Instalando as Ferramentas de desenvolvimento
    sudo dnf install --assumeyes golang
    sudo dnf install --assumeyes gcc
    sudo dnf install --assumeyes dotnet-sdk-5.0
    sudo dnf install --assumeyes aspnetcore-runtime-5.0
    sudo dnf install --assumeyes dotnet-runtime-5.0
    sudo dnf install --assumeyes git
    sudo dnf install --assumeyes git-lfs
    sudo dnf install --assumeyes android-tools
    sudo dnf install --assumeyes libstdc++-devel

    # Instalando outros programas
    sudo dnf install --assumeyes stacer
    sudo dnf install --assumeyes qt5-qtcharts
    sudo dnf install --assumeyes vlc
    sudo dnf install --assumeyes qt5-qtsvg
    sudo dnf install --assumeyes youtube-dl
    sudo dnf install --assumeyes snapd
    sudo dnf install --assumeyes flatpak
    sudo dnf install --assumeyes transmission
    sudo dnf install --assumeyes ffmpeg
    sudo dnf install --assumeyes steam
    sudo dnf install --assumeyes mokutil
    sudo dnf install --assumeyes fdupes
    sudo dnf install --assumeyes dnf-automatic
    sudo dnf install --assumeyes dconf-editor
    sudo dnf install --assumeyes audacity
    sudo dnf install --assumeyes gimp

    # Instalando pacotes para reportar erro automaticamente
    sudo dnf install --assumeyes abrt-desktop
    sudo dnf install --assumeyes abrt-java-connector
  }

  # Instala pacotes snap
  function instalar_pacotes_snap() {

    # Instalando snapd
    bash ./Install-Snapd.sh

    # Instalando pacotes snap
    sudo snap install spotify
    sudo snap install intellij-idea-community --classic
    sudo snap install pycharm-community --classic
    sudo snap install clion --classic
    sudo snap install flutter --classic
    sudo snap install kotlin --classic
    sudo snap install skype --classic
  }

  # Instala pacotes flatpak
  function instalar_pacotes_flatpak() {
    # Instalando o Flatpak
    bash ./Install-Flatpak.sh

    # Instalando o FlatHub
    bash ./Install-Flathub.sh
  }
  # Instalando o Google Chrome
  bash ./Install-GoogleChromeStable.sh

  # Instalando o Visual Studio Code
  bash ./Install-VisualStudioCode.sh

  # Instalando o PowerShell
  bash ./Install-PowerShell.sh

  # Instalando pacotes dnf
  instalar_pacotes_dnf

  # Instalando Java 8, 11 e 17
  bash ./Install-Java8.sh
  bash ./Install-Java11.sh
  bash ./Install-Java17.sh

  # Instalando pacotes snap
  instalar_pacotes_snap

  # Instalando pacotes flatpak
  instalar_pacotes_flatpak

  # Instalando o Docker
  bash ./Install-DockerDesktop.bash

  # Instalando o driver Nvidia
  bash ./Install-NvidiaDriver.sh

  # Instalando o VirtualBox
  bash ./Install-VirtualBox.sh

  # Instalando o MySQL Workbench
  bash ./Install-MySqlWorkBench.sh

  # Instalando o Peazip
  bash ./Install-Peazip.sh

  ## Atualizando todos os pacotes instalados
  bash ./Update-All.sh

  # Instalando script Update-All.sh
  instalar_script_update_all
}

# Configurando o Gnome Shell
bash ./Configurar-GnomeShell.bash

# Instalando o Minecraft
bash ./Install-Minecraft.sh

# Instalando o TechnicLauncher
bash ./Install-TechnicLauncher.sh

# Instalando o Weka
bash ./Install-Weka.sh

# Instalando o Orange
bash ./Install-OrangeDataMining.sh

# Instalando programas como root
sudo bash -c "$(declare -f run_as_root); run_as_root"
