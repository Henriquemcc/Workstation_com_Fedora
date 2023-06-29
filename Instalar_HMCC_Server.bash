#!/bin/bash

# Executa instalação como root
function run_as_root() {

  # Instala o script Wait-ForPidToShutdown.bash
    function instalar_script_wait_for_pid_to_shutdown() {
        file_name="Wait-ForPidToShutdown.bash"
        destination="/bin/$file_name"
        cp "./$file_name" "$destination"
        chmod +x "$destination"
    }

    #  Instala o script Update-All.bash
    function instalar_script_update_all() {
      file_name="Update-All.bash"
      destination="/bin/$file_name"
      sudo cp "./$file_name" "$destination"
      sudo chmod +x "$destination"
    }

  # Instala pacotes dnf
  function instalar_pacotes_dnf() {

    # Habilitando RPM Fusion
    bash ./Enable-RpmFusion.bash

    # Instalando os Sistemas de arquivos não nativos do linux
    dnf install --assumeyes ntfs-3g
    dnf install --assumeyes exfat-utils
    dnf install --assumeyes fuse
    dnf install --assumeyes fuse-exfat
    dnf install --assumeyes dnf-automatic
  }

  # Alterando o nome do computador
  hostnamectl set-hostname --static HMCC-Server

  # Instalando pacotes dnf
  instalar_pacotes_dnf

  # Instalando o Flatpak
  bash ./Install-Flatpak.bash

  # Instalando o Snap
  bash ./Install-Snapd.bash

  # Instalando Java
  bash ./Install-Java_8_Headless.bash
  bash ./Install-Java_20_Headless.bash

  # Instalando o Docker
  bash ./Install-DockerEngine.bash

  # Instalando o Dynamic DNS Update Client
  bash ./Install-Dynamic_Dns_Update_Client.bash

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash

  # Instalando o script Update-All.bash
  instalar_script_update_all

  # Instalando o script Wait-ForPidToShutdown.bash
  instalar_script_wait_for_pid_to_shutdown
}

# Instalando programas como root
sudo bash -c "$(declare -f run_as_root); run_as_root"
