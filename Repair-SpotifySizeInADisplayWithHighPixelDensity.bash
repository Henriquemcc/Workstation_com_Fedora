#!/bin/bash

resource_dir="./Resources/Spotify_for_displays_with_high_pixel_density"

# Adding initialization script
script_path="$HOME/.bin/Spotify.bash"
mkdir -p "$(dirname "$script_path")"
cp --force "${resource_dir}/Spotify.bash" "$script_path"
chmod -x "$script_path"

# Creating desktop file
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Spotify"
  echo "GenericName=Music Player"
  echo "Icon=/snap/spotify/current/usr/share/spotify/icons/spotify-linux-512.png"
  echo "TryExec=spotify"
  echo "Exec=/usr/bin/bash $HOME/.bin/Spotify.bash %U"
  echo "Terminal=false"
  echo "MimeType=x-scheme-handler/spotify;"
  echo "Categories=Audio;Music;Player;AudioVideo;"
  echo "StartupWMClass=spotify"
} > "$HOME/.local/share/applications/Spotify.desktop"
