#!/usr/bin/bash
# shellcheck source=/dev/null

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
pack=("rsync" "ssh" "tar" "gzip" "bzip2" "exa" "dialog" "fzf" "tree") # Array: to store needed packages
echo ""
tput bold setaf 2
echo "Installed on system :"

for pkg in "${pack[@]}"; do           # Loop: (for) to show packages install or not
  if [ "$(command -v "$pkg")" ]; then # packages available
    tput bold setaf 2
    echo "+" "$pkg"
    tput sgr0
    tput setaf 7
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
  tput setaf 2
  echo All packages are installed ":)"
  tput setaf 7
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
    tput setaf 1
    echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install:"
    tput setaf 7
    echo "$packagesNeeded" >&2
  fi
fi

wait # Command: to hold installation of packages
function Backup {
  echo "Select an option: "
  echo "1. Auto Backup"
  echo "2. Manual Backup"
  #echo "3. run test.sh file"
  echo "3. Exit"
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
      #[3])
      #source test.sh # Input: for yes
      #break
      #;;
    [3])
      echo -e "\e[31m Exiting...\e[0m" # Input: for no (will exit from program)
      exit
      ;;
    *) echo -e "\e[31m Invalid response..\e[0m" ;; # Input: invalid response (ask again)
    esac
  done
}
function Restore {

  echo 'text here'

}
echo ""
echo "What do you want to do ?"
echo "1. Backup"
echo "2. Restore"
echo "3. Exit"
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
    #[3])
    #source test.sh # Input: for yes
    #break
    #;;
  [3])
    echo -e "\e[31m Exiting...\e[0m" # Input: for no (will exit from program)
    exit
    ;;
  *) echo -e "\e[31m Invalid response..\e[0m" ;; # Input: invalid response (ask again)
  esac
done
