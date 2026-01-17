#!/bin/bash

WALLPAPERS_DIR="$HOME/Pictures/wallpapers"
SETTER_SCRIPT_PATH="$HOME/.config/scripts/wallpaper-setter.sh"
HYPRPAPER_CONFIG="$HOME/.config/hypr/hyprpaper.conf"
CURRENT_WALLPAPER=$(sed -n 's|^[[:space:]]*path[[:space:]]*=\s*||p' "$HYPRPAPER_CONFIG")

# array of every wallpapers in WALLPAPERS_DIR
wallpapers=()

for entry in "$WALLPAPERS_DIR"/*.{jpg,png,webp}; do
  if [[ ! -e "$entry" || "$(basename "$entry")" == "$(basename "$CURRENT_WALLPAPER")" ]]; then
    continue
  fi
  wallpapers+=("$entry")
done

# Generate random wallpaper and run wallpaper-setter.sh
random_wallpaper=$(printf '%s\n' "${wallpapers[@]}" | shuf -n 1)
source "$SETTER_SCRIPT_PATH" $random_wallpaper

# debug
printf '%s\n' "${wallpapers[@]}"
echo "$CURRENT_WALLPAPER"
