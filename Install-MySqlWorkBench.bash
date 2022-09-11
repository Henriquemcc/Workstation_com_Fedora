#!/bin/bash

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
sudo dnf install --assumeyes "$URL_RPM_MySQL_Repository"

# Installing MySQL WorkBench
sudo dnf install --assumeyes "$URL_RPM_MySQL_WorkBench"



