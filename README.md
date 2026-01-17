# Dotfiles Guide

## Editing Configuration
Use the `hyprconf` alias to edit Hyprland configuration files.

## Keybindings

### System Controls
- **Super** - Open wofi
- **Super + Escape** - Power menu
- **Super + Ctrl + M** - Exit Hyprland

### Window Management
- **Super + C** - Close selected window
- **Super + F** - Windowed fullscreen
- **Super + Shift + F** - Borderless fullscreen
- **Super + V** - Toggle floating
- **Super + T** - Toggle split
- **Super + P** - Pseudo

### Window Focus and Movement
- **Super + H/J/K/L** - Focus window (left/down/up/right)
- **Super + Shift + H/J/K/L** - Move window (left/down/up/right)
- **Super + Ctrl + H/J/K/L** - Resize window (left/down/up/right)

### Workspace Management
- **Super + Numbers** - Switch to numbered workspace
- **Super + Tab** - Switch to last workspace
- **Super + S** - Open special workspace
- **Super + Shift + Numbers** - Move window to numbered workspace
- **Super + Shift + S** - Move window to special workspace

### Applications
- **Super + Q** - Open terminal
- **Super + E** - Open file manager

### Media Controls
- **Print** - Take fullscreen screenshot
- **Shift + Print** - Mouse selection screenshot
- **Ctrl + Print** - Color picker
- **Super + Shift + W** - Change theme with kitty

## Theme Configuration (two options same result)

1. Update theme via Terminal UI (kitty):       
     Super + Shift + W

2. Set a wallpaper:
   ```bash
   # Either use ranger
   ranger  # Press 'x' on an image
   
   # Or use the wallpaper setter script
   ~/.config/wallpaper-setter.sh <image_path>
   ```

## Fish Shell Configuration (Tide)

```bash
tide configure --auto \
    --style=Rainbow \
    --prompt_colors='16 colors' \
    --show_time='24-hour format' \
    --rainbow_prompt_separators=Slanted \
    --powerline_prompt_heads=Sharp \
    --powerline_prompt_tails=Flat \
    --powerline_prompt_style='Two lines, character' \
    --prompt_connection=Disconnected \
    --powerline_right_prompt_frame=No \
    --prompt_spacing=Sparse \
    --icons='Many icons' \
    --transient=Yes
```

## Additional Configuration

### Required Packages [Work In Progress]
- nano-syntax-highlighting
- hypridle
- hyprlock

### Setting Default Browser
```bash
xdg-settings set default-web-browser firefox.desktop
```

if you don't use nvidia cards for hyprland comment the following vars inside hyprland.conf and edit gpu-selector.conf (hyprconf for both):
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia

super + G = gamemode
