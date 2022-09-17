#!/usr/bin/bash

tput setaf 1
echo "
   ▄████████    ▄████████    ▄▄▄▄███▄▄▄▄   ▀█████████▄   ▄██████▄  
  ███    ███   ███    ███  ▄██▀▀▀███▀▀▀██▄   ███    ███ ███    ███ 
  ███    ███   ███    ███  ███   ███   ███   ███    ███ ███    ███ 
 ▄███▄▄▄▄██▀   ███    ███  ███   ███   ███  ▄███▄▄▄██▀  ███    ███ 
▀▀███▀▀▀▀▀   ▀███████████  ███   ███   ███ ▀▀███▀▀▀██▄  ███    ███ 
▀███████████   ███    ███  ███   ███   ███   ███    ██▄ ███    ███ 
  ███    ███   ███    ███  ███   ███   ███   ███    ███ ███    ███ 
  ███    ███   ███    █▀    ▀█   ███   █▀  ▄█████████▀   ▀██████▀  
  ███    ███                                                       
"
tput setaf 5
echo "A application in development to Backup and Restore files"
echo ""
tput setaf 7

## Block: code to check developer's recommended packages in system
echo "Checking for required packages..."
pack=("rsync" "ssh" "tar" "gzip" "bzip2" "exa") # Array: to store needed packages
echo ""
tput bold setaf 2
echo "Installed on system :"

for pkg in "${pack[@]}"; # Loop: to show packages install or not
do
  if [ "$(command -v "$pkg")" ];  # packages available
  then
      tput bold setaf 2
      echo "+" "$pkg" 
      tput sgr0
      tput setaf 7
  else
    pack_to_inst+=("$pkg")   # package to install array
  fi
done

function inst {                # Function: to parse not installed packages
    for pkg_inst in "${pack_to_inst[@]}"; # Loop: packages not available
    do
      echo "$pkg_inst";
    done
}

packagesNeeded=$(inst)       # Variable: to store values from above function
length=${#pack_to_inst[@]}   # Variable: checking length of not installed array
echo ""
if [ "$length" -eq 0 ];   # Condition(if): if array length is 0
then
    tput setaf 2
    echo All packages are installed ":)"
    tput setaf 7
    echo ""
else                        # Condition(else): if array length is not 0
    tput bold setaf 1
    echo "NOT Installed :"
    tput blink 
    echo "$packagesNeeded"
    tput sgr0 setaf 7
    echo ""

    # Conditions: to install essential packages
    if [ -x "$(command -v apk)" ] 
      then
        sudo apk add --no-cache "$packagesNeeded"
    elif [ -x "$(command -v pacman)" ];
      then
        sudo pacman -S "$packagesNeeded"
    elif [ -x "$(command -v apt)" ];  
      then
        sudo apt install "$packagesNeeded"
    elif [ -x "$(command -v dnf)" ];
      then
        sudo dnf install "$packagesNeeded"
    elif [ -x "$(command -v zypper)" ]; 
      then 
        sudo zypper install "$packagesNeeded"
    else
        tput setaf 1
        echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install:"
        tput setaf 7
        echo "$packagesNeeded">&2;
    fi
fi

wait                    # Command: to hold installation of packages
bash auto_bck.sh        # Command: to run automatic backup script

