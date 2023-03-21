#!/usr/bin/bash
# Colours
export black="\033[0;30m"  # Black
export red="\033[31m"      # Red
export green="\033[0;32m"  # Green
export yellow="\033[0;33m" # Yellow
export blue="\033[0;34m"   # Blue
export purple="\033[0;35m" # Purple
export cyan="\033[0;36m"   # Cyan
export white="\033[0;37m"  # White
export bold="\033[1m"
export uline="\033[4m"
export reset="\033[0m"
export expand_bg="\033[K"
export blue_bg="\033[0;104m${expand_bg}"
export red_bg="\033[0;101m${expand_bg}"
export green_bg="\033[0;102m${expand_bg}"


echo -e "${red}
   ▄████████    ▄████████    ▄▄▄▄███▄▄▄▄   ▀█████████▄   ▄██████▄
  ███    ███   ███    ███  ▄██▀▀▀███▀▀▀██▄   ███    ███ ███    ███
  ███    ███   ███    ███  ███   ███   ███   ███    ███ ███    ███
 ▄███▄▄▄▄██▀   ███    ███  ███   ███   ███  ▄███▄▄▄██▀  ███    ███
▀▀███▀▀▀▀▀   ▀███████████  ███   ███   ███ ▀▀███▀▀▀██▄  ███    ███
▀███████████   ███    ███  ███   ███   ███   ███    ██▄ ███    ███
  ███    ███   ███    ███  ███   ███   ███   ███    ███ ███    ███
  ███    ███   ███    █▀    ▀█   ███   █▀  ▄█████████▀   ▀██████▀
  ███    ███
${reset}
"
echo -e "${purple}A application in development to Backup and Restore files ${reset}"
echo ""

## Block: code to check developer's recommended packages in system
echo "Checking for required packages..."
pack=("rsync" "ssh" "tar" "gzip" "bzip2" "exa" "dialog" "fzf" "tree") # Array: to store needed packages
echo ""
echo -e "${green}${bold}Installed on system :${reset}"

for pkg in "${pack[@]}"; do           # Loop: (for) to show packages install or not
  if [ "$(command -v "$pkg")" ]; then # packages available
    echo -e "${green}${bold}+ $pkg ${reset}"
  else
    pack_to_inst+=("$pkg") # package to install array
  fi
done

function inst {                            # Function: to parse not installed packages
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
function Backup {
  echo -e "\t Select an option: "
  echo -e "\t 1. Auto Backup"
  echo -e "\t 2. Manual Backup"
  #echo "3. run test.sh file"
  echo -e "\t 3. Exit"
  while true; do                        # Loop: (while) to get user input to proceed to further steps or not
    read -r -p "Enter an option: " file # Command: read user input
    echo ""
    case $file in # Conditon: switch case
    [1])
      source auto_bck.sh # Input: for yes
      break
      ;;
    [2])
      source bck.sh # Input: for yes
      break
      ;;
    [3])
      echo -e "${red}Exiting...${reset}" # Input: for no (will exit from program)
      exit
      ;;
    *) echo -e "${red}Invalid response..${reset}" ;; # Input: invalid response (ask again)
    esac
  done
}
function Restore {
  read -r -p "Enter Location: " location < <(find / -type d -name "BACKUP*" 2>/dev/null | fzf)
  echo "$location"
  echo "Restoring..."
}
echo ""
echo -e "${yellow}What do you want to do ?${reset}"
echo -e "1. Backup"
echo -e "2. Restore"
echo -e "3. Exit"
while true; do
  read -r -p "Enter an option: " file
  echo ""
  case $file in # Conditon: switch case
  [1])
    Backup
    break
    ;;
  [2])
    Restore
    break
    ;;
  [3])
    echo -e "${red} Exiting...${reset}" # Input: for no (will exit from program)
    exit
    ;;
  *) echo -e "${red} Invalid response..${reset}" ;; # Input: invalid response (ask again)
  esac
done
