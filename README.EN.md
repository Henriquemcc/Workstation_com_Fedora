[Versão em Português](README.md)

# Workstation with Fedora

This is the installation script of the programs which I use in my computer on [Fedora](https://getfedora.org) operating
system (Linux Distribution)

## How to run

With Fedora installed on your machine, open the 'Terminal' and on it copy and paste the following command:

```
sudo dnf install --assumeyes curl unzip bash;url_file="https://github.com/Henriquemcc/Fedora/archive/refs/heads/main.zip";path_download_file="/tmp/Fedora_main.zip";curl -L "$url_file" > "$path_download_file";unzip -o "$path_download_file" -d "/tmp";cd "/tmp/Fedora-main" || exit 1;bash ./Executar.sh;
```
