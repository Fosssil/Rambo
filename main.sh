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
echo " A application in development to Backup and Restore files"
echo ""
tput setaf 7

## Code to check recommended packages in system
echo "Checking for required packages..."
pack=("rsync" "ssh" "bnm" "tar" "gzip" "bunzip" "bzip2")
for pkg in "${pack[@]}";
do
if [ "$(command -v "$pkg")" ]; 
then
    tput setaf 2
    echo "$pkg"" exists on system" 
    tput setaf 7
else
pack_to_inst+=("$pkg")
fi
done
for pkg_inst in "${pack_to_inst[@]}";
do
    tput setaf 1
    echo "$pkg_inst" "not available"
    tput setaf 7
done