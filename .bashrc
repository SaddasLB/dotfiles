#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias ll='ls -la --color=auto'

### EFI Mount + Grub Update ###
alias grubdate='sudo mount /dev/nvme1n1p1 /mnt && sudo grub-mkconfig -o /boot/grub/grub.cfg'

### Files Shortcuts ###
alias hyprconf='nvim ~/.config/hypr/hyprland.conf'
alias aliases='nvim ~/.bashrc'
alias issues='nvim ~/Documents/issues.txt'

# QOL
alias fetch='fastfetch'

# Git Bare
alias dotfiles='/usr/bin/git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'
alias dotadd='~/.config/scripts/dotfiles-add.sh'

# set ranger to not use default config
export RANGER_LOAD_DEFAULT_RC=false
