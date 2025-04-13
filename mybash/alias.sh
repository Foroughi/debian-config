#!/bin/bash

alias ll='lsd -l -A'
alias b='btop'
alias l='lsd -A'
alias h='history'
alias c='clear'
alias C='cd ~ && clear'
alias r='cd ~'
alias cr='r && c'
alias sys='sudo systemctl'
alias j='sudo journalctl -r && c'
alias cj='c && j && c'
alias csys='c && sys && c'
alias gs='git status'
alias gP='git push'
alias gp='git pull'
alias gc='git commit -a -m $1'
alias sb='source ~/.bashrc && c'
alias ai='~/.config/assistant/run.sh'
alias lg="lazygit"
alias ld="lazydocker"
