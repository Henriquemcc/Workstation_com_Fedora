#!/bin/bash

# Executa instalação como root
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

      # Instalando os Sistemas de arquivos não nativos do linux
      sudo dnf install --assumeyes ntfs-3g
      sudo dnf install --assumeyes exfat-utils
      sudo dnf install --assumeyes fuse
      sudo dnf install --assumeyes fuse-exfat
      sudo dnf install --assumeyes dnf-automatic
    }

    # Instalando pacotes dnf
    instalar_pacotes_dnf

    # Instalando o Flatpak
    bash ./Install-Flatpak.sh

    # Instalando o Snapd
    bash ./Install-Snapd.sh

    # Instalando Java 8, 11 e 17
    bash ./Install-Java8.sh
    bash ./Install-Java11.sh
    bash ./Install-Java17.sh

    # Instalando o Docker
    bash ./Install-DockerEngine.bash

    # Atualizando todos os pacotes instalados
    bash ./Update-All.sh
}

# Instalando programas como root
sudo bash -c "$(declare -f run_as_root); run_as_root"