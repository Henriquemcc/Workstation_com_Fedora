#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 2 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Configurar módulos do kernel"
    echo "2 - Instalar configuração padrão ao gerenciador de pacotes DNF"
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
    bash ./ConfigurarModulosKernelLinux.bash
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash ./Configure-DnfPackageManager.bash
  fi


done
