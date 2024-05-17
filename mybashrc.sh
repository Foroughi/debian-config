alias l='ls -ls'
alias h='history'
alias c='clear'

fancygit --set-user-name " Ali"
fancygit --disable-time
fancygit --enable-bold-prompt
fancygit --enable-double-line

if [ "$TERM" == "tmux-256color" ]; then

    neofetch

fi


