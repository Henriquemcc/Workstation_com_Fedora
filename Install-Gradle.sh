#!/bin/bash

# Installing requirements
bash ./Install-SdkMan.sh
bash ./Install-Java8.sh
source "$HOME/.bashrc"

# Installing gradle
sdk install gradle
