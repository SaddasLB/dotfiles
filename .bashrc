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
alias hyprconf='~/.config/scripts/hyprconf-selector.sh'
alias aliases='nvim ~/.bashrc'
alias issues='nvim ~/Documents/issues.txt'

# QOL
alias fetch='fastfetch'

# Git Bare
alias dotfiles='/usr/bin/git --git-dir="$HOME/dotfiles/" --work-tree="$HOME"'
alias dotadd='~/.config/scripts/dotfiles-add.sh'

export EDITOR=nvim

# set ranger to not use default config
export RANGER_LOAD_DEFAULT_RC=false

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
