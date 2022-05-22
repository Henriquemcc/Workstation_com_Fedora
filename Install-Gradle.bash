#!/bin/bash

# Installing requirements
bash ./Install-SdkMan.bash
bash ./Install-Java8.bash
source "$HOME/.bashrc"

# Installing gradle
sdk install gradle
