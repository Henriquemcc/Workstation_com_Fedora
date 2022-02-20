[English version](README.EN.md)

# Workstation com Fedora

Este é o meu script de instalação dos programas que utilizo no meu computador no sistema operacional (distribuição
Linux) [Fedora](https://getfedora.org)

## Como executar

Com o Fedora estando instalado em seu computador, abra o programa 'Terminal' e nele copie e cole o seguinte comando:

```
path_old_current_dir="$(pwd)";sudo dnf install --assumeyes curl unzip bash;url_file="https://github.com/Henriquemcc/Fedora/archive/refs/heads/main.zip";path_download_file="/tmp/Fedora_main.zip";curl -L "$url_file" > "$path_download_file";unzip -o "$path_download_file" -d "/tmp";cd "/tmp/Fedora-main" || exit 1;bash ./Executar.sh;cd "$path_old_current_dir" || exit 1;
```
