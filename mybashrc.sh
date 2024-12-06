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

    #alias c='clear && neofetch'
    neofetch

fi

complete -cf sudo

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$PATH:/opt/nvim-linux64/bin"
eval "$(direnv hook bash)"


# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='\'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
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
