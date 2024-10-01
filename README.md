[English version](README.EN.md)

# Workstation com Fedora, CentOS, Red Hat, AlmaLinux ou Oracle Linux

Este é o meu script de instalação dos programas que utilizo no meu computador na minha distribuição Linux.

Distribuições Linux suportadas: 

[Fedora](https://fedoraproject.org/)

[CentOS](https://www.centos.org/)

[Red Hat Enterprise Linux](https://www.redhat.com/pt-br/technologies/linux-platforms/enterprise-linux)

[AlmaLinux](https://almalinux.org/)

[Oracle Linux](https://www.oracle.com/br/linux/)

## Como executar

Com o Fedora, CentOS, RHEL, AlmaLinux ou Oracle Linux estando instalado em seu computador, abra o programa 'Terminal' e nele copie e cole o seguinte comando:

```
path_old_current_dir="$(pwd)";sudo dnf install --assumeyes curl unzip bash;url_file="https://github.com/Henriquemcc/Fedora/archive/refs/heads/main.zip";path_download_file="/tmp/Fedora_main.zip";curl -L "$url_file" > "$path_download_file";unzip -o "$path_download_file" -d "/tmp";cd "/tmp/Fedora-main" || exit 1;bash ./Executar.bash;cd "$path_old_current_dir" || exit 1;
```
