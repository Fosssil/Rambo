#!/usr/bin/env bash
dialog --begin 10 30 --backtitle "Rambo by fossil" \
    --title "Important" \
    --msgbox 'From this step, this application will take backup as per your demand and will store files to your desired location.
    * After this window you will a input prompt in your terminal.
    * You have to put the full path(i.e. Relative Path) of the file/files.
    * Please Do not leave it empty.
    * Empty line end the taking input.

      Thanks' 20 70 # Command: (dialog) customised to display ouput
clear

dialog --begin 10 30 --backtitle "Rambo by fossil" \
    --title "!!! CAUTION !!!" \
    --msgbox 'Some files from System Root(.i.e. / ) can not be successfully backup.
    They may show error with permission, specially private key files or they may be system services.
    Will fix someday.
    Goodluck :) ' 20 70 # Command: (dialog) customised to display ouput
clear

#echo -e "\e[1;32mEnter your files location to take backup: \e[0m"
#echo -e "\e[31m(end with an empty line)\e[0m"
destination=$HOME/BACKUP_"$(date "+%F_%H-%M")"
cd /
declare -a target # Array: (declare) name target to store targeted locations
readarray -t target < <(fzf -m \
    --tiebreak=begin,index \
    --border=rounded --ansi \
    --marker='+' --prompt='/' \
    --header='Select files' --preview='tree -C -L 3 -x') # Array(target): (readarray) from customised fzf tool

if [ "${#target[@]}" -eq 0 ]; then # Condition: (if) array is empty
    echo "Please enter something..."
else                                                      # Condition: (else)
    COUNTER=1                                             # Variable: counter used in below for loop
    echo -e "\e[32mFollowing files will be backup: \e[0m" # Condition: (else) array have locations
    for list in "${target[@]}"; do
        echo -e "\e[33m$COUNTER. $list\e[0m"
        COUNTER=$((COUNTER + 1)) # Counter: (increment)
    done
    read -r -p "Do you want to continue [y/n]: " yn # Variable: (read) to continue backup or not
    case $yn in                                     # Condition: (case)
    [yY])                                           # Input: for yes
        mkdir "$destination"
        rsync -Rrv --progress "${target[@]}" "$destination" # Command: rsync to backup files, -n to dry_run
        ;;
    *) echo "Exiting..." ;; # Input: for anything other than yes
    esac
fi
