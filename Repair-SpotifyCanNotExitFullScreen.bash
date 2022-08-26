#!/bin/bash

sed -i "/\b\(app.window.position\)\b/d" -- "$HOME"/snap/spotify/current/.config/spotify/prefs
