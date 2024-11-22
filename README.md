hyprland: 

super -> open wofi 

super + escape -> power menu

super+c -> close selected window

super+h/j/k/l -> focus left/down/up/right window 

super+shift+h/j/k/l -> move window to the left/down/up/right 

super+ctrl+h/j/k/l -> resize window to the left/down/up/right

super+q -> terminal 

super+e -> file manager

super+s -> open special workspace 

super+numbers -> switch to number workspace

super+tab -> switch with last workspace

super+shift+number -> move selected window to target workspace 

super+shift+number -> move selected window to target workspace 

super+shift+s -> move selected window to special workspace

super+f -> fullscreen 

super+shift+f -> borderless fullscreen

super+v -> toggle floating
super+t -> toggle split
super+p -> pseudo

super+ctrl+m -> exit hyprland

print -> screenshot
ctrl+print -> color picker

super+shift+w -> change theme with kitty

setting a theme: 
- open ranger and press x on an image
- super+shift+w -> change theme with kitty
- use script + image path

to edit the hyprland conf files use the hyprconf alias

tide configuration:
tide configure --auto --style=Rainbow --prompt_colors='16 colors' --show_time='24-hour format' --rainbow_prompt_separators=Slanted --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Many icons' --transient=Yes

packages: nano-syntax-highlighting hypridle hyprlock

setting default browser:
xdg-settings set default-web-browser firefox.desktop
