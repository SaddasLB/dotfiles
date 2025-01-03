#!/bin/bash

is_wofi_running() {
    pgrep -x wofi >/dev/null
}

if is_wofi_running; then
    killall wofi
    exit 0
fi

entries="⏻ Shutdown\n⭮ Reboot\n⏾ Hibernate\n⛒ Lock\n⇠ Logout"
selected=$(echo -e $entries | wofi \
    --width 160 \
    --height 252 \
    --location=top_right \
    --xoffset=-8 \
    --yoffset=8 \
    --dmenu \
    --cache-file /dev/null \
    --hide_search=true \
    --style ~/.config/wofi/power-menu.css \
    | awk '{print tolower($2)}')

case $selected in
    shutdown)
        poweroff
        ;;
    reboot)
        reboot
        ;;
    hibernate)
        systemctl hibernate
        ;;
    lock)
        hyprlock
        ;;
    logout)
        hyprctl dispatch exit
        ;;
esac
