if status is-interactive
  
  function fish_greeting
    echo \n
  end

    # Commands to run in interactive sessions can go here
    
    alias ll='ls -la'

    ### EFI Mount + Grub Update ###
    alias grubdate='sudo mount /dev/nvme1n1p1 /mnt && sudo grub-mkconfig -o /boot/grub/grub.cfg'

    ### Files Shortcuts ###
    alias hyprconf='nvim ~/.config/hypr/hyprland.conf'
    alias aliases='nvim ~/.config/fish/config.fish'
    alias issues='nvim ~/Documents/issues.txt'

    # QOL
    alias fetch='fastfetch'

    # Git Bare
    alias dotfiles='/usr/bin/git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'
    alias dotadd='~/.config/scripts/dotfiles-add.sh'

    # Kitty
    alias kssh='kitty +kitten ssh'
    alias icat='kitty +kitten icat'
    
    # Wallpaper swap
    alias wallpaperone='hyprctl hyprpaper preload "~/Pictures/wallpapers/wallpaper.jpg" && hyprctl hyprpaper wallpaper ",~/Pictures/wallpapers/wallpaper.jpg" && wal -i ~/Pictures/wallpapers/wallpaper.jpg'

    alias wallpapertwo='hyprctl hyprpaper preload "~/Pictures/wallpapers/wallpaper2.jpg" && hyprctl hyprpaper wallpaper ",~/Pictures/wallpapers/wallpaper2.jpg" && wal -i ~/Pictures/wallpapers/wallpaper2.jpg'

    set -Ux RANGER_LOAD_DEFAULT_RC false

end
