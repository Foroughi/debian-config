#!/bin/bash

alias l='ls -ls -a'
alias h='history'
alias c='clear && neofetch'
alias r='cd ~'
alias cr='r && c'
alias sys='sudo systemctl'
alias j='sudo journalctl -r && c'
alias cj='c && j && c'
alias csys='c && sys && c'

fancygit --set-user-name " Ali"
fancygit --disable-time
fancygit --enable-bold-prompt
fancygit --enable-double-line

if [ "$TERM" == "tmux-256color" ]; then

    #alias c='clear && neofetch'
    neofetch
    
fi


