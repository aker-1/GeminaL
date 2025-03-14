#!/bin/bash

BLUE_BOLD="\e[1;34m"
YELLOW_BOLD="\e[1;93m"
RESET="\e[0m"
RED="\e[1;91m"
GREEN="\e[1;92m"
WHITE="\e[1;97m"
PINK="\e[1;95m"

echo " "
function funlogo(){
  clear
    echo -e "${BLUE_BOLD}
█████████║██████╗ ██████████╗██ ████╗  ██║███████ ██║   
██╔══════║██╔═══╝ ████╗ ████║██║████╗  ██║██╔══██╗██║     
██╚═█████║█████╗  ██╔████╔██║██║██╔██╗ ██║███████║██║     
██╔═══███║██╔══╝  ██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     
█████████║███████╗██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗
╚════════╚══════ ╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ══════╝
    ${RESET}"
}
funlogo

echo -e "${WHITE}Say...What's you ask? ${RESET}"
read ask


GEMINI_API_KEY="AIzaSyCmPBhLFoM6sj6bPme2wnJ46Dwt7tutrUk"

response=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}" \
-H 'Content-Type: application/json' \
-X POST \
-d "{ \"contents\": [{ \"parts\": [{ \"text\": \"$ask\" }] }] }" | jq -r '.candidates[0].content.parts[0].text')


echo "Response From GeminaL : "
echo "$response"