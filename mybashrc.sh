#!/bin/bash

alias l='ls -ls -a'
alias h='history'
alias c='clear'
alias tree='find . -print | sed -e "s;[^/]*/;|____;g;s;____|; |;g"'

. ~/.fzf.bash

export FZF_COMPLETION_TRIGGER='\'

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in    
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

fancygit --set-user-name " Ali"
fancygit --disable-time
fancygit --enable-bold-prompt
fancygit --enable-double-line

if [ "$TERM" == "tmux-256color" ]; then

    alias c='clear && neofetch'
    neofetch
    

fi


