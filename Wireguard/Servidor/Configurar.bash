#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo)" ]; then
      sudo bash "$0"
      exit $?
    else
      echo "Sudo is not installed"
      exit 1
    fi
  fi
}

# Running as root
run_as_root

# Creating wireguard configuration directory and changing the current directory to it
mkdir -p /etc/wireguard
cd /etc/wireguard || exit

# Setting permission
umask 077

# Generating private and public keys
wg genkey | tee server.key | wg pubkey > server.pub

# Copying bash script used to determine the default network interface
cp ./Resources/bin/Get-DefaultInterfaceIPv4.bash /bin/Get-DefaultInterfaceIPv4.bash
chmod 755 /bin/Get-DefaultInterfaceIPv4.bash
cp ./Resources/bin/Get-DefaultInterfaceIPv6.bash /bin/Get-DefaultInterfaceIPv6.bash
chmod 755 /bin/Get-DefaultInterfaceIPv6.bash

# Creating configuration file
{
  echo "[Interface]"
  echo "Address = 10.100.0.1/24, fd08:4711::1/64"
  echo "ListenPort = 51820"
  echo "PostUp = iptables -w -t nat -A POSTROUTING -o $(/bin/bash /bin/Get-DefaultInterfaceIPv4.bash) -j MASQUERADE; ip6tables -w -t nat -A POSTROUTING -o $(/bin/bash /bin/Get-DefaultInterfaceIPv4.bash) -j MASQUERADE"
  echo "PostDown = iptables -w -t nat -D POSTROUTING -o $(/bin/bash /bin/Get-DefaultInterfaceIPv4.bash) -j MASQUERADE; ip6tables -w -t nat -D POSTROUTING -o $(/bin/bash /bin/Get-DefaultInterfaceIPv4.bash) -j MASQUERADE"
} > "wg0.conf"

# Adding private key to the configuration file
echo "PrivateKey = $(cat server.key)" >> "wg0.conf"

# Enabling IP Forwarding
if ! grep -q "net.ipv4.ip_forward=1" "/etc/sysctl.conf"; then
  echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
fi
if ! grep -q "net.ipv6.conf.all.forwarding=1" "/etc/sysctl.conf"; then
  echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.conf
fi

# Starting and enabling wireguard service
systemctl enable wg-quick@wg0.service
systemctl daemon-reload
systemctl start wg-quick@wg0

