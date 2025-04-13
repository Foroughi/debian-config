space="⠀"
getTagStarter (){
    [ -z "$1" ] || echo ''
}

getTagEnder (){
    [ -z "$1" ] || echo ''
}

wrapTextWithColor() {
    echo '\[$(tput setab ' $3 ')\]\[$(tput setaf ' $2 ')\]'$1'\[$(tput sgr0)\]'
}

drawTag() {
    local len=${#1}
    echo "$space$(wrapTextWithColor "\$(getTagStarter $1)" $3 0)$(wrapTextWithColor $1 $2 $3)$(wrapTextWithColor "\$(getTagEnder $1)" $3 0)"
}

getgittag(){
    git rev-parse --abbrev-ref head 2> /dev/null
}

getTerminalWidth(){
    tput cols
}
setPS1(){
    t=3;
    text="\n"
    # text=""

    # Draw user
    local user="Ali"
    t=$((t + ${#user} + 5))
    text+=$(drawTag $user 7 239)

    # Draw Current path
    local currentDir=$(pwd)
    currentDir="${currentDir/$HOME/"~"}"
    t=$((t + ${#currentDir} + 3))
    text+=$(drawTag $currentDir 15 27)

    # Draw Middle spaces
    text+='###'

    # Draw Git Tag
    local currentBranch=$(getGitTag)
    if [ "" != "$currentBranch" ]
    then
        t=$((t + ${#currentBranch} + 5))
        text+=$(drawTag "$space$(getGitTag)" 255 199)
    fi

    if [[ -n $flox_runtime_dir ]]; then
        flox=$flox_env_description
        t=$((t + ${#flox} + 5))
        text+=$(drawtag "💻$space$flox" 255 236)
    fi

    if [[ -n $SSH_CLIENT || -n $SSH_CONNECTION ]]; then
        ssh_ip=$(echo $SSH_CLIENT | awk '{print $1}')
        t=$((t + ${#ssh_ip} + 5))
        text+=$(drawtag "🔐$space$ssh_ip" 255 236)
    fi

    # Draw Ending
    text+="\n ➔ "

    # Draw Spaces
    local spaces=""
    local remainingSpace=$(( $(getTerminalWidth) - $t ))
    for ((i = 0; i < $remainingSpace; i++)); do
        spaces+=" "
    done


    PS1="${text//###/$spaces}"
}

# bind "set vi-cmd-mode-string "\1\e[34;1m\2CMD\1\e[0m\2""
# bind "set vi-ins-mode-string "\1\e[34;1m\2INS\1\e[0m\2""
PROMPT_COMMAND='setPS1'
