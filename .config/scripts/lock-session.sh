lock_cmd = pidof hyprlock || hyprlock ; hyprctl keyword decoration:screen_shader ''

on-timeout = loginctl lock-session && hyprctl keyword decoration:screen_shader ~/.config/hypr/shaders/grayscale.frag

WORK IN PROGRESS
