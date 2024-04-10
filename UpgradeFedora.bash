#!/bin/bash

# Importing function run_as_root and get_os_type
source OsInfo.bash

# Exiting menu if the operating system is not fedora
if [ "$(get_os_type)" != "fedora" ]; then
  exit  1
fi

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 5 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Atualizar para o Fedora 35"
    echo "2 - Atualizar para o Fedora 36"
    echo "3 - Atualizar para o Fedora 37"
    echo "4 - Atualizar para o Fedora 38"
    echo "5 - Atualizar para o Fedora 39"
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
    bash Upgrade-FedoraToASpecificVersion.bash 35
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash Upgrade-FedoraToASpecificVersion.bash 36
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash Upgrade-FedoraToASpecificVersion.bash 37
  elif [ "$opcao_selecionada" -eq 4 ]; then
    bash Upgrade-FedoraToASpecificVersion.bash 38
  elif [ "$opcao_selecionada" -eq 5 ]; then
    bash Upgrade-FedoraToASpecificVersion.bash 39
  fi
done
