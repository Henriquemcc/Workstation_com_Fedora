#!/bin/bash

# Installing requirements
bash ./Install-SdkMan.bash
 bash ./Install-Java_8_Headless.bash
source "$HOME/.bashrc"

# Installing gradle
sdk install gradle
