#!/usr/bin/env bash
# shellcheck source=/dev/null
source inputfile.sh > /dev/null

#code to find package manager >>>>>>

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

#code to install paackges from desired package manager >>>>>

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

#code to solve bug, if no. of not installed packages is 0 >>>>>>

#distro=("redhat linux" "debian linux" "gentoo linux")
#echo element 0 = "${distro[0]}"
#echo element 1 = "${distro[2]}"
#
#
#
#echo direct length = ${#distro[@]}
#length=${#distro[@]}
#echo length by variable = "$length"
#
#if [ "$length" -eq 0 ]
#then
#echo hello
#else
#echo not hello
#fi

# code for rsync testing >>>>>>

echo ""
echo "Following files are going to be backed up :)"
echo "${myArray[@]}"
myArray=$(bash inputfile.sh | tr "\n"  " ")

        target=("${myArray[@]}")
        destination=test/
        for items in "${target[@]}";
        do
        tput setaf 2
        eval rsync -Rrnv --progress "$items"  "$destination";
        tput setaf 7
        echo ""
        done
        echo ""
        exa -al --color=always -F "$destination"