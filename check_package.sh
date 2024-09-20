#!/usr/bin/env bash

source color.sh

## Block: code to check developer's recommended packages in system
echo "Checking for required packages..."
pack=("rsync" "ssh" "tar" "gzip" "bzip2" "exa" "dialog" "fzf" "tree") # Array: to store needed packages
echo ""
echo -e "${green}${bold}Installed on system :${reset}"

for pkg in "${pack[@]}"; do          # Loop: (for) to show packages install or not
	if [ "$(command -v "$pkg")" ]; then # packages available
		echo -e "${green}${bold}+ $pkg ${reset}"
	else
		pack_to_inst+=("$pkg") # package to install array
	fi
done

function inst {                           # Function: to parse not installed packages
	for pkg_inst in "${pack_to_inst[@]}"; do # Loop: packages not available
		echo "$pkg_inst"
	done
}

packagesNeeded=$(inst)     # Variable: to store values from above function
length=${#pack_to_inst[@]} # Variable: checking length of not installed array
echo ""
if [ "$length" -eq 0 ]; then # Condition(if): if array length is 0
	echo -e "${green}All packages are installed :) ${reset}"
	echo ""
else # Condition(else): if array length is not 0
	tput bold setaf 1
	echo "NOT Installed :"
	tput blink
	echo "$packagesNeeded"
	tput sgr0 setaf 7
	echo ""

	# Conditions: to install essential packages
	if [ -x "$(command -v apk)" ]; then # Option: -x with test to check if file exist and is executable
		sudo apk add --no-cache "${pack_to_inst[@]}"
	elif [ -x "$(command -v pacman)" ]; then
		sudo pacman -S "${pack_to_inst[@]}"
	elif [ -x "$(command -v apt)" ]; then
		sudo apt update
		sudo apt install "${pack_to_inst[@]}"
	elif [ -x "$(command -v dnf)" ]; then
		sudo dnf install "${pack_to_inst[@]}"
	elif [ -x "$(command -v zypper)" ]; then
		sudo zypper install "${pack_to_inst[@]}"
	else
		echo "${red}FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install:${reset}"
		echo "$packagesNeeded" >&2
	fi
fi

wait # Command: to hold installation of packages
