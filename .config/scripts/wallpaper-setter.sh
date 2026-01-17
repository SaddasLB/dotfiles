#!/bin/bash

# TERMINAL STRING EXAMPLE FOR DEBUGGING
# $HOME/.config/scripts/wallpaper-setter.sh $HOME/Pictures/wallpapers/wallpaper.jpg

# Log file for debugging
#log_file="/tmp/wallpaper-setter.log"
# Function to log messages
#log_message() {
#    echo "$(date): $1" >> "$log_file"
#}
#touch "$log_file"
#chmod 666 "$log_file"

#log_message "Script started"
echo -e "--- SCRIPT STARTED ---"

# hyprpaper.conf path
config_file="$HOME/.config/hypr/hyprpaper.conf"

# image path selected with ranger
input_path="$1"

#log_message "Selected image path: $input_path"
echo "IMAGE PATH: $input_path"

# function that checks if the path is already relative (ex. $HOME/.config/..)
#is_relative_path(){
#  case "$1" in
#    '$HOME'*) return 0
#    ;;
#    *) return 1
#    ;;
#  esac
#}

#log_message "Converting path from absolute to relative"
echo "...Converting path from absolute to relative..."
selected_image="${input_path/$HOME/\~}"
#log_message "Converted path: $selected_image"
echo "CONVERTED PATH: $selected_image"
  

# check if wallpaper has been selected
if [ -z "$(eval echo "$selected_image")" ]; then
#  log_message "ERROR: no wallpaper selected"
  echo "ERROR: no wallpaper selected"
  exit 1
fi

# check if wallpaper exists
if [ ! -f "$(eval echo "$selected_image")" ]; then
#  log_message "ERROR: selected wallpaper doesn't exists"
  echo "ERROR: selected wallpaper doesn't exists"
  exit 1
fi

# update wallpaper path
echo -n "Attempting to update hyprpaper.conf wallpaper... "

if sed -i "s|^[[:space:]]*path[[:space:]]*=.*|  path = ${selected_image}|" "$config_file"; then
    #log_message "Updated wallpaper in hyprpaper.conf"
    echo -e "ok\n>> hyprpaper.conf wallpaper updated"
else
    #log_message "Failed to update wallpaper in hyprpaper.conf"
    echo "ERROR: hyprpaper.conf wallpaper update failed" 
fi

# Set new wallpaper
#log_message "Attempting to set new wallpaper"
echo -n "Attempting to set new wallpaper... "
if hyprctl hyprpaper wallpaper ", $selected_image"; then
    #log_message "Successfully set new wallpaper"
    echo ">> Wallpaper setted" 
else
    #log_message "Failed to set new wallpaper"
    echo "ERROR: wallpaper set failed" 
fi

# Update pywal
#log_message "Attempting to update pywal"
echo -e "\nAttempting to update pywal...\n"
if wal -i "$(eval echo "$selected_image")"; then
  #log_message "Successfully updated pywal"
  echo -e "\n>> Pywal updated"
else
  #log_message "Failed to update pywal"
  echo "ERROR: pywal update failed"
fi

# Update mako
#log_message "Updating mako"
echo -e "Updating mako\n"
$HOME/.config/mako/update-theme.sh 

# Uncomment to test notification colours
#notify-send "Script Notification Test"

#log_message "Script completed"
echo -e "\n--- SCRIPT ENDED ---"
