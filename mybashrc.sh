#!/bin/bash

. ~/.config/.fancy-git/prompt.sh

alias l='ls -ls -a'
alias h='history'
alias c='clear && neofetch'
alias r='cd ~'
alias cr='r && c'
alias sys='sudo systemctl'
alias j='sudo journalctl -r && c'
alias cj='c && j && c'
alias csys='c && sys && c'

if [ "$TERM" == "tmux-256color" ]; then

    neofetch

fi

complete -cf sudo

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$PATH:/opt/nvim-linux64/bin"
eval "$(direnv hook bash)"

export FZF_COMPLETION_TRIGGER='\'
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --tmux --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --tmux --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --tmux --preview 'dig {}'                   "$@" ;;
    *)            fzf --tmux --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
