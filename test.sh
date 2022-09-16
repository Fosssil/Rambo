#!/usr/bin/env bash

#declare -A osInfo;
#osInfo[/etc/redhat-release]=yum
#osInfo[/etc/arch-release]=pacman
#osInfo[/etc/gentoo-release]=emerge
#osInfo[/etc/SuSE-release]=zypp
#osInfo[/etc/debian_version]=apt-get
#osInfo[/etc/alpine-release]=apk
#for f in "${!osInfo[@]}"
#do
#    if [[ -f $f ]];then
#        echo Package manager: ${osInfo[$f]}
#    fi
#done
#
#packagesNeeded=$pkg_inst
#if [ -x "$(command -v apk)" ]
#then
#sudo apk add --no-cache "$packagesNeeded"
#elif [ -x "$(command -v pacman)" ];
#then
#sudo pacman -S "$packagesNeeded"
#elif [ -x "$(command -v apt-get)" ];
#then
#sudo apt-get install "$packagesNeeded"
#elif [ -x "$(command -v dnf)" ];
#then
#sudo dnf install "$packagesNeeded"
#elif [ -x "$(command -v zypper)" ]; 
#then sudo zypper install "$packagesNeeded"
#else 
#echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install:
#$packagesNeeded">&2;
#fi
#test_function() {
#echo Test
#}
#result=$(test_function)
#echo "$result" is saved in a variable for later use


target=("/home/$USER/.bash_history" "/home/$USER/.bashrc")
destination=/home/"$USER"/test/
for f in "${target[@]}";
do
rsync -vn --progress "$f" "$destination";
done
echo ""
exa -al --color=always -F