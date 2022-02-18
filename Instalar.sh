#!/bin/bash

function configurar_gnome_shell() {
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

function instalar_script_update_all() {
  sudo cp ./Update-All.sh /bin/Update-All.sh
  sudo chmod +x /bin/Update-All.sh
}

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

  # Instalando as Extensões do Gnome shell
  sudo dnf install --assumeyes gnome-shell-extension-updates-dialog
  sudo dnf install --assumeyes gnome-shell-extension-dash-to-dock

  # Instalando as Ferramentas de desenvolvimento
  sudo dnf install --assumeyes golang
  sudo dnf install --assumeyes gcc
  sudo dnf install --assumeyes dotnet-sdk-5.0
  sudo dnf install --assumeyes aspnetcore-runtime-5.0
  sudo dnf install --assumeyes dotnet-runtime-5.0
  sudo dnf install --assumeyes git
  sudo dnf install --assumeyes git-lfs
  sudo dnf install --assumeyes android-tools

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
  sudo dnf install --assumeyes gnome-tweaks
  sudo dnf install --assumeyes dconf-editor
  sudo dnf install --assumeyes audacity
  sudo dnf install --assumeyes chrome-gnome-shell

  # Instalando pacotes para reportar erro automaticamente
  sudo dnf install --assumeyes abrt-desktop
  sudo dnf install --assumeyes abrt-java-connector
}

function instalar_pacotes_snap() {

  # Instalando snapd
  bash ./Install-Snapd.sh

  # Instalando pacotes snap
  sudo snap install spotify
  sudo snap install intellij-idea-community --classic
  sudo snap install pycharm-community --classic
  sudo snap install flutter --classic
  sudo snap install kotlin --classic
  sudo snap install skype --classic
}

function instalar_pacotes_flatpak() {
  # Instalando o Flatpak
  bash ./Install-Flatpak.sh

  # Instalando o FlatHub
  bash ./Install-Flathub.sh
}

# Configurando o Gnome Shell
configurar_gnome_shell

# Instalando o Google Chrome
bash ./Install-GoogleChromeStable.sh

# Instalando o Visual Studio Code
bash ./Install-VisualStudioCode.sh

# Instalando o PowerShell
bash ./Install-PowerShell.sh

# Instalando pacotes dnf
instalar_pacotes_dnf

# Instalando Java 8
bash ./Install-Java8.sh

# Instalando pacotes snap
instalar_pacotes_snap

# Instalando pacotes flatpak
instalar_pacotes_flatpak

# Instalando o Docker
bash ./Install-Docker.sh

# Instalando o driver Nvidia
bash ./Install-NvidiaDriver.sh

# Instalando o VirtualBox
bash ./Install-VirtualBox.sh

# Instalando o Minecraft
bash ./Install-Minecraft.sh

# Instalando o TechnicLauncher
bash ./Install-TechnicLauncher.sh

# Instalando o MySQL Workbentch
bash ./Install-MySqlWorkBench.sh

# Instalando o Peazip
bash ./Install-Peazip.sh

# Instalando o Proton VPN
bash ./Install-ProtonVPN.sh

## Atualizando todos os pacotes instalados
bash ./Update-All.sh

# Instalando script Update-All.sh
instalar_script_update_all
