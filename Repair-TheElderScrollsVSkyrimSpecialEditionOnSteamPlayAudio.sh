#!/bin/bash

# https://www.reddit.com/r/linux_gaming/comments/99i4se/skyrim_on_linux_steam_play_no_voiceno_music_audio/

# Printing url where the solution was founded
solution_src_url="https://www.reddit.com/r/linux_gaming/comments/99i4se/skyrim_on_linux_steam_play_no_voiceno_music_audio/"
echo "Solution founded in $solution_src_url"

# Installing requirements
sudo dnf install winetricks --assumeyes

# Setting Skyrim folder
skyrim_folder="$HOME/.steam/steam/steamapps/compatdata/489830/"

# Running Winetricks in pfx folder
# shellcheck disable=SC2034
WINEPREFIX="$skyrim_folder/pfx"
winetricks --force xact

# This part requires user GUI interaction
echo ""
echo "This part requires user interaction"
echo "in the Libraries tab create overrides for the properties 'xaudio2_6' and 'xaudio2_7', setting both to 'native'"
echo ""
(firefox $solution_src_url || google-chrome-stable $solution_src_url) &
winecfg