#!/bin/bash

# Getting screen resolution
screen_resolution="$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')"

# Getting width and height
IFS="x"
read -ra strarr <<<"$screen_resolution"
width="${strarr[0]}"
height="${strarr[0]}"

# Getting the difference
#width_diff="$(("$width" / 2560))"
width_diff="$(bc -l <<< "$width / 1920")"
echo "$width_diff"
#height_diff="$(("$height" / 1440))"
height_diff="$(bc -l <<< "$height / 1080")"
echo "$height_diff"

# Getting the multiply size
if [ "$(bc -l  <<< "$width_diff < $height_diff")" -eq 1 ]; then
  echo "true"
  multiply_size=$width_diff
else
  echo "false"
  multiply_size=$height_diff
fi
#multiply_size="$((width_diff > height_diff ? width_diff : height_diff))"
echo "$multiply_size"

# Launching spotify
spotify --force-device-scale-factor=$multiply_size "$@"
