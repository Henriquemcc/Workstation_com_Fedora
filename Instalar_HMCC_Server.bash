#!/bin/bash

# Executa instalação como root
function run_as_root() {

    #  Instala script Update-All.bash
    function instalar_script_update_all() {
      sudo cp ./Update-All.bash /bin/Update-All.bash
      sudo chmod +x /bin/Update-All.bash
    }

    # Instala pacotes dnf
    function instalar_pacotes_dnf() {

      # Habilitando RPM Fusion
      bash ./Enable-RpmFusion.bash

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
    bash ./Install-Flatpak.bash

    # Instalando o Snapd
    bash ./Install-Snapd.bash

    # Instalando Java 8, 11 e 17
    bash ./Install-Java8.bash
    bash ./Install-Java11.bash
    bash ./Install-Java17.bash

    # Instalando o Docker
    bash ./Install-DockerEngine.bash

    # Instalando o Dynamic DNS Update Client
    bash ./Install-Dynamic_Dns_Update_Client.bash

    # Atualizando todos os pacotes instalados
    bash ./Update-All.bash
}

# Instalando programas como root
sudo bash -c "$(declare -f run_as_root); run_as_root"