#!/bin/bash

# Executa instalação como root
function run_as_root() {

  # Alterando o nome do computador
  hostnamectl set-hostname --static rpi

  # Configurando o Systemd Resolved
  bash ./ConfigurarSystemdResolved.bash

  # Configurando DNF
  bash ./ConfigurarDnfPackageManager.bash

  # Configurando DNF Automatic
  bash ./Enable-AutomaticUpdatesWithDnfAutomatic.bash

  # Instalando o Wireguard
  bash ./Wireguard/Install-Wireguard.bash

  # Instalando o Dynamic DNS Update Client
  bash ./Install-Dynamic_Dns_Update_Client.bash

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash
  
  # Desabilitando Fedora Cockpit
  systemctl disable cockpit.socket
}

# Instalando programas como root
sudo bash -c "$(declare -f run_as_root); run_as_root"
