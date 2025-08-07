#!/usr/bin/env bash
source src/color.sh

echo ""
echo -e "${yellow}What do you want to do ?${reset}"
echo -e "1. Auto Backup"
echo -e "2. Manual Backup"
echo -e "3. Restore"
echo -e "4. Exit"
while true; do
  read -r -p "Enter an option: " file
  echo ""
  case $file in # Conditon: switch case
  [1])
    source src/backup/auto_backup.sh
    break
    ;;
  [2])
    source src/backup/manual_backup.sh
    break
    ;;
  [3])
    source src/restore/restore.sh
    break
    ;;
  [4])
    echo -e "${red} Exiting...${reset}" # Input: for no (will exit from program)
    exit
    ;;
  *) echo -e "${red} Invalid response..${reset}" ;; # Input: invalid response (ask again)
  esac
done
