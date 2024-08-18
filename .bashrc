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
alias hyprconf='sudo nvim ~/.config/hypr/hyprland.conf'
alias aliases='sudo nvim ~/.bashrc'
alias issues='sudo nvim ~/Documents/issues.txt'

# Macros
alias cleanfetch='clear && fastfetch'
alias ds='env XDG_SESSION_TYPE=x11 discord'

# Git Bare
alias dotfiles='/usr/bin/git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'

