#!/usr/bin/env bash
source color.sh

function bck {
	dialog --begin 10 30 --backtitle "Rambo by fossil" \
		--title "!!! TIP !!!" \
		--msgbox ' Use <TAB> to select multiple files ' 10 40 # Command: (dialog) customised to display ouput
	clear
	#echo -e "\e[1;32mEnter your files location to take backup: \e[0m"
	#echo -e "\e[31m(end with an empty line)\e[0m"
	#destination=$HOME/BACKUP_"$(date "+%F_%H-%M")"
	destination=$HOME/BACKUP
	cd "$HOME" || return
	declare -a target # Array: (declare) name target to store targeted locations
	readarray -t target < <(find . -type d | fzf -m \
		--tiebreak=begin,index \
		--border=rounded --ansi \
		--marker='+' --prompt='/' \
		--header='Select files' --preview='ls {}') # Array(target): (readarray) from customised fzf tool
		###### Important === ❯ find . -type f | fzf -m --tiebreak=begin,index --border=rounded --ansi --marker='+' --prompt='/' --header='Select files' --preview='cat {}'

	if [ "${#target[@]}" -eq 0 ]; then # Condition: (if) array is empty
		echo "Please enter something..."
	else                                                   # Condition: (else)
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
}

function auto_bck {
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
	while true; do                                  # Loop: (while) to get user input to proceed to further steps or not
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
	#destination=$HOME/BACKUP_"$(date "+%F_%H-%M")"
	destination=$HOME/BACKUP
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

}

echo -e "\t Select an option: "
echo -e "\t 1. Auto Backup"
echo -e "\t 2. Manual Backup"
#echo "3. run test.sh file"
echo -e "\t 3. Exit"
while true; do                       # Loop: (while) to get user input to proceed to further steps or not
	read -r -p "Enter an option: " file # Command: read user input
	echo ""
	case $file in # Conditon: switch case
	[1])
		auto_bck # Input: for yes
		break
		;;
	[2])
		bck # Input: for yes
		break
		;;
	[3])
		echo -e "${red}Exiting...${reset}" # Input: for no (will exit from program)
		exit
		;;
	*) echo -e "${red}Invalid response..${reset}" ;; # Input: invalid response (ask again)
	esac
done
