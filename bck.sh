#!/usr/bin/env bash
#dialog --begin 10 30 --backtitle "Rambo by fossil" \
#    --title "Important" \
#    --msgbox 'This is an important message' 10 30
#clear
#
#dialog --begin 10 30 --backtitle "System Information" \
#    --title "About" \
#    --msgbox 'This is an entirely open source software.' 10 30
#sleep 1s
#clear

echo -e "\e[1;32mEnter your files location to take backup: \e[0m"
echo -e "\e[31m(end with an empty line)\e[0m"
array=()

while IFS= read -r line; do
    [[ $line ]] || break # break if line is empty
    array+=("$line")

done

if [ "${#array[@]}" -eq 0 ]; then
    echo "Please enter something..."
else

    echo -e "\e[32mFollowing files will be backup: \e[0m"
    for list in "${array[@]}"; do
        echo -e "\e[33m$list\e[0m"
    done
fi