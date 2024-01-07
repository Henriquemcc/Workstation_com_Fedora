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

VERSION_ID="$(awk -F= '$1=="VERSION_ID" { print $2 ;}' /etc/os-release)"
URL_RPM_MySQL_WorkBench=""
URL_RPM_MySQL_Repository=""

if [ "$VERSION_ID" == "36" ];then
  URL_RPM_MySQL_WorkBench="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-8.0.30-1.fc36.x86_64.rpm"
  URL_RPM_MySQL_Repository="https://dev.mysql.com/get/mysql80-community-release-fc36-1.noarch.rpm"

elif [ "$VERSION_ID" == "35" ]; then
  URL_RPM_MySQL_WorkBench="https://downloads.mysql.com/archives/get/p/8/file/mysql-workbench-community-8.0.29-1.fc35.x86_64.rpm"
  URL_RPM_MySQL_Repository="https://dev.mysql.com/get/mysql80-community-release-fc35-3.noarch.rpm"

elif [ "$VERSION_ID" == "34" ]; then
  URL_RPM_MySQL_WorkBench="https://downloads.mysql.com/archives/get/p/8/file/mysql-workbench-community-8.0.27-1.fc34.x86_64.rpm"
  URL_RPM_MySQL_Repository="https://dev.mysql.com/get/mysql80-community-release-fc34-4.noarch.rpm"
fi

# Installing MySQL Repository
dnf install --assumeyes "$URL_RPM_MySQL_Repository"

# Installing MySQL WorkBench
dnf install --assumeyes "$URL_RPM_MySQL_WorkBench"



