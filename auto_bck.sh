#!/usr/bin/bash
# shellcheck source=/dev/null
echo -e "\e[35mFollowing files are going to be backed up :) \e[0m"
source inputfile.sh 

# code for rsync >>>>>
while true; do

read -p "Do you want to proceed? (y/N) " yn

case $yn in 
	[yY] ) echo -e "\e[32m ok, we will do stuff \e[0m";
		    break;;
	[nN] ) echo -e "\e[31m exiting...\e[0m";
		    exit;;
	* )  echo -e "\e[31m Invalid response..\e[0m";
    
esac
done
echo ""
echo " Doing stuff... "
myArray=$(bash inputfile.sh | tr "\n"  " ")
sleep 1s
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
exa -al --color=always -F $destination
tree -ah $destination
