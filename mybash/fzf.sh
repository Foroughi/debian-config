#!/bin/bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_COMPLETION_TRIGGER='>'
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
    h)            h | fzf --tmux                                  "$@" ;;
    *)            fzf --tmux --preview 'cat -n {}' "$@" ;;
  esac
}
