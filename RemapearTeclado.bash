#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo)" ]; then
      sudo bash "$0" "$@"
      exit $?
    else
      echo "Sudo is not installed"
      exit 1
    fi
  fi
}

# Running as root
run_as_root "$@"

# Instalando xremap
xremap_path="/home/${SUDO_USER}/.cargo/bin/xremap"
if ! [ -f "$xremap_path" ]; then
  dnf install --assumeyes cargo
  sudo -u "$SUDO_USER" cargo install xremap --features gnome
fi

# Criando arquivo de remapeamento do teclado
keyboard_mapper_file="/home/${SUDO_USER}/keyboard.yml"
if ! [ -f "$keyboard_mapper_file" ]; then
{
  echo "modmap:"
  echo "  - name: Left Key replacement"
  echo "    remap:"
  echo "      KEY_RIGHTALT: KEY_LEFT"
} > "$keyboard_mapper_file"
fi

# Executando o xremap
"$xremap_path" "$keyboard_mapper_file" & exit