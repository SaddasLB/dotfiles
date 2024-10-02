#!/bin/sh

# stole it here:
# https://github.com/elegaanz/dotfiles/blob/main/.config/mako/update-theme.sh

. "${HOME}/.cache/wal/colors.sh"

conffile="$HOME/.config/mako/config"

# Associative array, color name -> color code.
declare -A colors
colors=(
    ["background-color"]="$background"
    ["text-color"]="$color1"
)

for color_name in "${!colors[@]}"; do
  # replace first occurance of each color in config file
  sed -i "0,/^$color_name.*/{s//$color_name=${colors[$color_name]}/}" $conffile
done

makoctl reload

