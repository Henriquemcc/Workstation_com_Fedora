[Versão em Português](README.md)

# Workstation with Fedora, CentOS, Red Hat or AlmaLinux

This is my installation script for the programs I use on my computer in my Linux distribution.

Supported Linux distributions:

[Fedora](https://fedoraproject.org/)

[CentOS](https://www.centos.org/)

[Red Hat Enterprise Linux](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux)

[AlmaLinux](https://almalinux.org/)

## How to run

With Fedora, CentOS, RHEL or AlmaLinux installed on your machine, open the 'Terminal' and on it copy and paste the following command:

```
path_old_current_dir="$(pwd)";sudo dnf install --assumeyes curl unzip bash;url_file="https://github.com/Henriquemcc/Fedora/archive/refs/heads/main.zip";path_download_file="/tmp/Fedora_main.zip";curl -L "$url_file" > "$path_download_file";unzip -o "$path_download_file" -d "/tmp";cd "/tmp/Fedora-main" || exit 1;bash ./Executar.bash;cd "$path_old_current_dir" || exit 1;
```
