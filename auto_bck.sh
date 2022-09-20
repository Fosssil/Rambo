#!/usr/bin/bash
destination=test/ # Variable: store destination address where, backup files will be placed
target=(
    /home/"$USER"/.bash_history
    /home/"$USER"/.bashrc
    /home/"$USER"/.ssh
    /home/"$USER"/.npm
    /home/"$USER"/Documents
    /home/"$USER"/.zshrc
    /home/"$USER"/.local/share/kwalletd
    /home/"$USER"/.local/share/kwin
    /home/"$USER"/.zsh_history
    /home/"$USER"/.local/share/plasma
    /home/"$USER"/.local/share/konsole
    /home/"$USER"/token.txt
) # Array: store targated locations
COUNTER=1       # Variable: counter used in below for loop
echo -e "\e[35mFollowing files are going to be backed up :) \e[0m"
for i in "${target[@]}"; do     # Loop: (for) to display the array items to user .i.e. target location
    echo -e "\e[33m" "$COUNTER." "$i" "\e[0m"
    COUNTER=$((COUNTER + 1))
done

# code for rsync
while true; do                                     # Loop: (while) to get user input to proceed to further steps or not
    read -r -p "Do you want to proceed? (y/N) " yn # Command: read user input
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

#for items in "${myArray[@]}"; do # Loop: (for) to pass target address one by one to rync command
tput setaf 2
rsync -Rnr --progress "${target[@]}" "$destination" # Command: rsync to backup files, -n to dry_run
tput setaf 7
echo ""
#done

echo ""
exa -al --color=always -F $destination # Command: the colorfull subtitute for 'ls' command
tree -ah $destination                  # Command: display the tree structure of destination folder
