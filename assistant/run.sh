#!/bin/bash
#docker run -p 11434:11434 -v ~/.config/assistant/run_command.sh:/host/run_command.sh --name ollama -d --privileged ollama/ollama --name ollam &
docker start ollama >> /dev/null

while ! curl -s http://localhost:11434/api/tags > /dev/null; do
    sleep 1
done

#while true; do
#    read -p "> " user_input
#    if [[ "$user_input" == "" ]]; then
#        break
#    fi
docker exec -it ollama ollama run linux-assistant #"$user_input"
#done
docker stop ollama >> /dev/null
