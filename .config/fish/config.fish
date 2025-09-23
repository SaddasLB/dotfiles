if status is-interactive
  
  function fish_greeting
    echo \n
  end

    # Commands to run in interactive sessions can go here
    
    alias ll='ls -la'

    # Power options
    alias sdn='sudo shutdown now'
    alias rbn='sudo reboot now'

    ### EFI Mount + Grub Update ###
    alias grubdate='sudo mount /dev/nvme1n1p1 /mnt && sudo grub-mkconfig -o /boot/grub/grub.cfg'

    ### Files Shortcuts ###
    alias hyprconf='~/.config/scripts/hyprconf-selector.sh'
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


    set -gx EDITOR nvim

    set -Ux RANGER_LOAD_DEFAULT_RC false

end

