#!/bin/bash

#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 29 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Docker Engine"
    echo "2 - Driver Nvidia"
    echo "3 - FlatHub"
    echo "4 - Flatpak"
    echo "5 - GitHub Cli"
    echo "6 - Git Repo"
    echo "7 - Google Chrome Stable"
    echo "8 - Google Chrome Beta"
    echo "9 - Google Earth"
    echo "10 - Gradle"
    echo "11 - Java 8"
    echo "12 - Java 11"
    echo "13 - Java 17"
    echo "14 - Microsoft Teams"
    echo "15 - MySQL WorkBench"
    echo "16 - Orange Data Mining"
    echo "17 - Peazip"
    echo "18 - Proton VPN"
    echo "19 - Python 3 Pip"
    echo "20 - R Studio"
    echo "21 - Rust Programming Language"
    echo "22 - SDK Man"
    echo "23 - Snapd"
    echo "24 - Speed Test Cli"
    echo "25 - Technic Launcher"
    echo "26 - VirtualBox"
    echo "27 - Visual Studio Code"
    echo "28 - Weka (Waikato Environment for Knowledge Analysis)"
    echo "29 - Docker Desktop"

    read -r _opcao_selecionada
  done

  function_return_variable="$_opcao_selecionada"
}

opcao_selecionada=-1
while [ $opcao_selecionada -ne 0 ]; do

  # Obtendo opção selecionada pelo usuário
  obter_opcao
  opcao_selecionada="$function_return_variable"

  if [ "$opcao_selecionada" -eq 1 ]; then
    bash ./Install-DockerEngine.bash
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash ./Install-NvidiaDriver.bash
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash ./Install-Flathub.bash
  elif [ "$opcao_selecionada" -eq 4 ]; then
    bash ./Install-Flatpak.bash
  elif [ "$opcao_selecionada" -eq 5 ]; then
    bash ./Install-GithubCli.bash
  elif [ "$opcao_selecionada" -eq 6 ]; then
    bash ./Install-GitRepo.bash
  elif [ "$opcao_selecionada" -eq 7 ]; then
    bash ./Install-GoogleChromeStable.bash
  elif [ "$opcao_selecionada" -eq 8 ]; then
    bash ./Install-GoogleChromeBeta.bash
  elif [ "$opcao_selecionada" -eq 9 ]; then
    bash ./Install-GoogleEarth.bash
  elif [ "$opcao_selecionada" -eq 10 ]; then
    bash ./Install-Gradle.bash
  elif [ "$opcao_selecionada" -eq 11 ]; then
    bash ./Install-Java8.bash
  elif [ "$opcao_selecionada" -eq 12 ]; then
    bash ./Install-Java11.bash
  elif [ "$opcao_selecionada" -eq 13 ]; then
    bash ./Install-Java17.bash
  elif [ "$opcao_selecionada" -eq 14 ]; then
    bash ./Install-MicrosoftTeams.bash
  elif [ "$opcao_selecionada" -eq 15 ]; then
    bash ./Install-MySqlWorkBench.bash
  elif [ "$opcao_selecionada" -eq 16 ]; then
    bash ./Install-OrangeDataMining.bash
  elif [ "$opcao_selecionada" -eq 17 ]; then
    bash ./Install-Peazip.bash
  elif [ "$opcao_selecionada" -eq 18 ]; then
    bash ./Install-ProtonVPN.bash
  elif [ "$opcao_selecionada" -eq 19 ]; then
    bash ./Install-Python3Pip.bash
  elif [ "$opcao_selecionada" -eq 20 ]; then
    bash ./Install-RStudio.bash
  elif [ "$opcao_selecionada" -eq 21 ]; then
    bash ./Install-RustLang.bash
  elif [ "$opcao_selecionada" -eq 22 ]; then
    bash ./Install-SdkMan.bash
  elif [ "$opcao_selecionada" -eq 23 ]; then
    bash ./Install-Snapd.bash
  elif [ "$opcao_selecionada" -eq 24 ]; then
    bash ./Install-SpeedTestCli.bash
  elif [ "$opcao_selecionada" -eq 25 ]; then
    bash ./Install-TechnicLauncher.bash
  elif [ "$opcao_selecionada" -eq 26 ]; then
    bash ./Install-VirtualBox.bash
  elif [ "$opcao_selecionada" -eq 27 ]; then
    bash ./Install-VisualStudioCode.bash
  elif [ "$opcao_selecionada" -eq 28 ]; then
    bash ./Install-Weka.bash
  elif [ "$opcao_selecionada" -eq 29 ]; then
    bash ./Install-DockerDesktop.bash
  fi
done
