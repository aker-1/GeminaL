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
API_FILE="your_api_key.txt"
if [[ -f "$API_FILE" ]];then
    GEMINI_API_KEY=$(cat "$API_FILE")
else 
    read -p "$(echo -e "${WHITE}Do you have an api ? (y/n) : ")" have_api
    if [[ "$have_api" == 'y' || "$have_api" == 'yes' ]];then
        read -p "$(echo -e "${WHITE}Enter Your api : ")" GEMINI_API_KEY
    else 
        echo -e "${RED}Oh, you need an API Key to continue.${RESET}"
        echo -e "${RED}Visit this website https://aistudio.google.com/apikey${RESET}"
        exit 1
    fi
fi

response_api=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}" \
-H 'Content-Type: application/json' \
-X POST \
-d "{ \"contents\": [{ \"parts\": [{ \"text\": \"test\" }] }] }" | jq -r '.candidates[0].content.parts[0].text')

if [[ "$response_api" == 'null' ]];then
    echo -e "${RED}================== IN CORRECT CHOICE ==================${RESET}"
    exit 1
else 
    echo -e "${GREEN}==================== CORRECT CHOICE ====================${RESET}"
    echo -e "${WHITE}Your api is saved in your_api_key.txt file${RESET}"
    echo "$GEMINI_API_KEY" > your_api_key.txt
fi

while true; do
  echo -e "${WHITE}Say...What's your ask? ${RESET}"
  read ask

  response=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}" \
  -H 'Content-Type: application/json' \
  -X POST \
  -d "{ \"contents\": [{ \"parts\": [{ \"text\": \"$ask\" }] }] }" | jq -r '.candidates[0].content.parts[0].text')

  echo -e "${BLUE_BOLD}========================================================${RESET}"
  echo -e "${YELLOW_BOLD}$response${YELLOW_BOLD}"
done