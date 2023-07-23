#!/usr/bin/env bash
source color.sh

echo ""
echo -e "${yellow}What do you want to do ?${reset}"
echo -e "1. Backup"
echo -e "2. Restore"
echo -e "3. Upload to Cloud"
echo -e "4. Download from Cloud"
echo -e "5. Exit"
while true; do
    read -r -p "Enter an option: " file
    echo ""
    case $file in # Conditon: switch case
    [1])
        source backup.sh
        break
        ;;
    [2])
        source restore.sh
        break
        ;;
    [3])
        echo -e "${green}Uploading to AWS...${reset}"
        echo -e "${green}...${reset}"
        /bin/python upload.py
        break
        ;;
    [4])
        echo -e "${green}Downloading to Downloads folder${reset}"
        echo -e "${green}...${reset}"
        /bin/python download.py
        break
        ;;
    [5])
        echo -e "${red} Exiting...${reset}" # Input: for no (will exit from program)
        exit
        ;;
    *) echo -e "${red} Invalid response..${reset}" ;; # Input: invalid response (ask again)
    esac
done
