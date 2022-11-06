#!/usr/bin/bash
dialog --begin 10 30 --backtitle "Rambo by fossil" \
    --title "Important" \
    --msgbox '* In this option user do not have to manually input the files location.
* Program will automatically select the pre-defined files location.

      Thanks' 20 70 # Command: (dialog) customised to display ouput
clear
destination=$HOME/BACKUP_"$(date "+%F_%H-%M")"
target=(
    "$HOME/.bash_history"
    "$HOME/.bashrc"
    "$HOME/.ssh"
    "$HOME/.npm"
    "$HOME/.zshrc"
    "$HOME/.zsh_history"
    "$HOME/.local/share/kwalletd"
    "$HOME/.local/share/kwin"
    "$HOME/.local/share/plasma"
    "$HOME/.local/share/konsole"
    "$HOME/.config/autostart/"
    "$HOME/.config/Code - OSS/User/settings.json"
    "$HOME/.config/VSCodium/User/settings.json"
    "$HOME/.config/kwalletrc"
    "$HOME/.config/latte"
    "$HOME/token.txt"
    "$HOME/Documents"
) # Array: store targated locations

COUNTER=1 # Variable: counter used in below for loop
echo -e "\e[35mFollowing files are going to be backed up :) \e[0m"

for i in "${target[@]}"; do # Loop: (for) to display the array items to user .i.e. target location
    echo -e "\e[33m" "$COUNTER." "$i" "\e[0m"
    COUNTER=$((COUNTER + 1))
done

# code for rsync
while true; do                                     # Loop: (while) to get user input to proceed to further steps or not
    read -r -p "Do you want to proceed? (y/n) " yn # Command: read user input
    case $yn in                                    # Conditon: switch case
    [yY])
        echo -e "\e[32m ok, we will do stuff \e[0m" # Input: for yes
        break
        ;;
    [nN])
        echo -e "\e[31m exiting...\e[0m" # Input: for no (will exit from program)
        exit
        ;;
    *) echo -e "\e[31m Invalid response..\e[0m" ;; # Input: invalid response (ask again)
    esac
done

echo ""
echo " Doing stuff... "
destination=$HOME/BACKUP_"$(date "+%F_%H-%M")"
mkdir "$destination"
echo "$destination" created

#for items in "${myArray[@]}"; do # Loop: (for) to pass target address one by one to rync command
tput setaf 2
rsync -Rrv --progress "${target[@]}" "$destination" # Command: rsync to backup files, -n to dry_run
tput setaf 7
echo ""
#done

echo ""
exa -al --color=always -F "$destination" # Command: the colorfull subtitute for 'ls' command
tree -ah "$destination"                  # Command: display the tree structure of destination folder
