space="⠀"
getTagStarter (){
    [ -z "$1" ] || echo ''
}

getTagEnder (){
    [ -z "$1" ] || echo ''
}

wrapTextWithColor() {
    local text="$1"
    local fg="$2"
    local bg="$3"
    local color_seq=""

    [[ "$fg" -ne 0 ]] && color_seq+="\$(tput setaf $fg)"
    [[ "$bg" -ne 0 ]] && color_seq+="\$(tput setab $bg)"

    echo "\[$color_seq\]$text\[$(tput sgr0)\]"
}

wrapTextWithColor2() {
    echo '\[$(tput setab ' $3 ')\]\[$(tput setaf ' $2 ')\]'$1'\[$(tput sgr0)\]'
}

drawTag() {
    local len=${#1}
    echo "$space$(wrapTextWithColor "\$(getTagStarter $1)" $3 0)$(wrapTextWithColor $1 $2 $3)$(wrapTextWithColor "\$(getTagEnder $1)" $3 0)"
}

drawTag2() {
    local icon="$1"
    local text=$2
    local fg="$3"
    local bg="$4"
    local sep_bg=237

    [[ -n "$5" ]] && sep_bg=0

    echo "$(wrapTextWithColor "\$(getTagStarter 1)" $bg $sep_bg)$(wrapTextWithColor "$icon " $fg $bg)$(wrapTextWithColor " $text " 15 237)"
}

getGitTag(){
    git rev-parse --abbrev-ref head 2> /dev/null
}

getTerminalWidth(){
    tput cols
}

getCamelCase() {
    local input="$*"
    local result=""
    local word=""
    local i

    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        if [[ "$char" =~ [a-zA-Z0-9] ]]; then
            word+="$char"
        else
            [[ -n "$word" ]] && result+="${word^}"
            word=""
            result+="$char"
        fi
    done

    [[ -n "$word" ]] && result+="${word^}"
    echo "$result"
}

setPS1(){
    t=2;
    text="\n "
    # text=""

    # Draw user
    local user="Ali"
    t=$((t + ${#user} + 5))
    text+=$(drawTag2 "" $user 232 222 true)

    # Draw Current path
    local currentDir=$(pwd)
    currentDir="${currentDir/$HOME/"~"}"
    t=$((t + ${#currentDir} + 5))
    text+=$(drawTag2 "" $currentDir 15 27)

    # Draw Middle spaces
    text+='###'

    if [[ -n $TERM_PROGRAM ]]; then
        prog=$TERM_PROGRAM
        t=$((t + ${#prog} + 5))
        text+=$(drawTag2 "" "$prog" 236 85 true)
    fi

    # Draw Git Tag
    local currentBranch=$(getGitTag)
    if [ "" != "$currentBranch" ]
    then
        t=$((t + ${#currentBranch} + 5))
        text+=$(drawTag2 "" "$(getGitTag)" 236 218)
    fi

    if [[ -n $FLOX_RUNTIME_DIR ]]; then
        flox=$FLOX_ENV_DESCRIPTION
        t=$((t + ${#flox} + 5))
        text+=$(drawTag2 "" "$flox" 236 39)
    fi

    if [[ -n $SSH_CLIENT || -n $SSH_CONNECTION ]]; then
        ssh_ip=$(echo $SSH_CLIENT | awk '{print $1}')
        t=$((t + ${#ssh_ip} + 5))
        text+=$(drawTag2 "🖧" "$ssh_ip" 232 34)
    fi

    # Draw Ending
    text+="\n  ➔ "

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
