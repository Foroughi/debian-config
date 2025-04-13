#!/bin/bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_COMPLETION_TRIGGER='\\'
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#ffffff,fg+:#ffffff,bg:-1,bg+:#262626
  --color=hl:#1382f1,hl+:#1382f1,info:#ffffff,marker:#1382f1
  --color=prompt:#1382f1,spinner:#1382f1,pointer:#1382f1,header:#1382f1
  --color=border:#bababa,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="Find" --border-label-pos="0" --preview-window="border-double"
  --marker="" --pointer="➔" --separator="─"
  --scrollbar="│" --layout="reverse-list" --info="right"'
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --style full --tmux 70%,70%                                      "$@" ;;
    export|unset) fzf --style full --tmux 70%,70% --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf  --style full --tmux 70%,70% --preview 'dig {}'                   "$@" ;;
    h)            h | fzf --style full --tmux  70%,70%                                 "$@" ;;
    *)            fzf --style full --tmux --preview 'cat -n {}' "$@" ;;
  esac
}
