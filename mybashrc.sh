#!/bin/bash

export PATH=~/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/opt/nvim-linux-x86_64/bin
#. ~/.config/.fancy-git/prompt.sh
. ~/.config/mybash/mybash.sh
alias ll='lsd -l -A'
alias b='btop'
alias l='lsd -A'
alias h='history'
alias c='clear && neofetch'
alias r='cd ~'
alias cr='r && c'
alias sys='sudo systemctl'
alias j='sudo journalctl -r && c'
alias cj='c && j && c'
alias csys='c && sys && c'
alias gs='git status'
alias gp='git push'
alias gc='git commit -a -m $1'
alias sb='source ~/.bashrc && c'
alias ai='~/.config/assistant/run.sh'
if [ "$TERM" == "tmux-256color" ]; then

    neofetch

fi

complete -cf sudo

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#[ -d ~/.fzf ] && export PATH="$PATH:~/.fzf/bin"
#export PATH="$PATH:/opt/nvim-linux64/bin"

if [ -n "$(which direnv)" ]
then
    eval "$(direnv hook bash)"
fi


if [ -n "$(which gh)" ]
then
    eval "$(gh copilot alias -- bash)"
fi


#eval "$(starship init bash)"
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
#eval "$(fzf --bash)"


if [ -n "$TMUX" ]; then
  echo -ne '\e[6 q'
fi
