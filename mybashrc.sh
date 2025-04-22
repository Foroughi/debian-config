#!/bin/bash

export PATH=~/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/opt/nvim-linux-x86_64/bin:~/.local/share/npm/bin/

. ~/.config/mybash/mybash.sh
. ~/.config/mybash/alias.sh
. ~/.config/mybash/fzf.sh
. ~/.config/mybash/flox.sh
if [ "$TERM" == "tmux-256color" ]; then

    if [ -n "$(which neofetch)" ]
    then
        neofetch
    fi

fi

complete -cf sudo

if [ -n "$(which direnv)" ]
then
    eval "$(direnv hook bash)"
fi


if [ -n "$(which gh)" ]
then
    eval "$(gh copilot alias -- bash)"
fi

if [ -n "$TMUX" ]; then
  echo -ne '\e[6 q'
fi

#if i am connecting via ssh and tmux is available , itll run tmux by default
if [ -n "$SSH_CONNECTION" ]; then
  if command -v tmux >/dev/null 2>&1; then
    if [ -z "$TMUX" ]; then
      tmux attach || tmux new && exit
    fi
  fi
fi
