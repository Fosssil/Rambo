#!/usr/bin/env bash
dialog --begin 10 30 --backtitle "Rambo by fossil" \
    --title "Important" \
    --msgbox 'From this step, this appllication will take backup as per your demand and will store files to your desired location.
    * After this window you will a input prompt in your terminal.
    * You have to put the full path(i.e. Relative Path) of the file/files.
    * Please Do not leave it empty.
    * Empty line end the taking input.

      Thanks' 20 50
clear
#
#dialog --begin 10 30 --backtitle "System Information" \
#    --title "About" \
#    --msgbox 'This is an entirely open source software.' 10 30
#sleep 1s
#clear

echo -e "\e[1;32mEnter your files location to take backup: \e[0m"
echo -e "\e[31m(end with an empty line)\e[0m"
array=() # Array: to store files location

while IFS= read -r line; do # Loop: (while) to enter data from user into array
    [[ $line ]] || break    # break if line is empty
    array+=("$line")
done

if [ "${#array[@]}" -eq 0 ]; then # Condition: (if) array is empty
    echo "Please enter something..."
else

    echo -e "\e[32mFollowing files will be backup: \e[0m" # Condition: (else) array have locations
    for list in "${array[@]}"; do
        echo -e "\e[33m$list\e[0m"
    done
fi
