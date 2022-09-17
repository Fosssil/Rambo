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

## Code to checkDeveloper recommended packages in system >>>
echo "Checking for required packages..."
pack=("rsync" "ssh" "tar" "gzip" "bzip2" "exa")
echo ""
tput bold setaf 2
echo "Installed on system :"
for pkg in "${pack[@]}"; 
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
function inst {
    for pkg_inst in "${pack_to_inst[@]}"; # packages not available
    do
    echo "$pkg_inst";
    done
}
packagesNeeded=$(inst)
length=${#pack_to_inst[@]}  # checking length of not installed array
echo ""
if [ "$length" -eq 0 ];   # if array length is 0
then
    tput setaf 2
    echo All packages are installed ":)"
    tput setaf 7
    echo ""
else                        # if array length is not 0
    tput bold setaf 1
    echo "NOT Installed :"
    tput blink 
    echo "$packagesNeeded"
    tput sgr0 setaf 7
    echo ""

    ## Code to install essential packages
    if [ -x "$(command -v apk)" ]
      then
        sudo apk add --no-cache "$packagesNeeded"
    elif [ -x "$(command -v pacman)" ];
      then
        sudo pacman -S "$packagesNeeded"
    elif [ -x "$(command -v apt)" ];  # reminder: update to APT
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

wait
bash test.sh

