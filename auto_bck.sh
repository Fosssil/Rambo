#!/usr/bin/bash
# shellcheck source=/dev/null
echo -e "\e[35mFollowing files are going to be backed up :) \e[0m"
source inputfile.sh # Command: to import input file of targeted locations

# code for rsync
while true;                 # Loop: to get user input to proceed to further steps or not
do
    read -p "Do you want to proceed? (y/N) " yn        # Command: read user input
    case $yn in                         # Conditon: switch case
	    [yY] ) echo -e "\e[32m ok, we will do stuff \e[0m"; # Input: for yes
		        break;;
	    [nN] ) echo -e "\e[31m exiting...\e[0m";        # Input: for no (will exit from program)
		        exit;;
	    * )  echo -e "\e[31m Invalid response..\e[0m"; # Input: invalid response (ask again)
    esac
done

echo ""
echo " Doing stuff... "
myArray=$(bash inputfile.sh | tr "\n"  " ") # Array: store input from inputfile.sh, tr to trim next line
sleep 1s;                   # Command: sleep for 1 sec, because program is too fast :))
target=("${myArray[@]}")    # Variable: store values from array in variable
destination=test/           # Variable: store destination address where, backup files will be placed

for items in "${target[@]}"; # Loop: to pass target address one by one to rync command
do
    tput setaf 2
    eval rsync -Rrnv --progress "$items"  "$destination"; # Command: rsync to backup files, -n to dry_run
    tput setaf 7
    echo ""
done

echo ""
exa -al --color=always -F $destination # Command: the colorfull subtitute for 'ls' command
tree -ah $destination       # Command: display the tree structure of destination folder