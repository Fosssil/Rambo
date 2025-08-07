#!/usr/bin/env bash
source ../color.sh

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
else                                                    # Condition: (else)
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
