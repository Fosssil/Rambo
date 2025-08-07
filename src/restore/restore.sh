#!/usr/bin/env bash
# shellcheck disable=SC1091
source ../color.sh

read -r -p "Enter Location: " location < <(find / -type d -name "BACKUP*" 2>/dev/null | fzf)
echo "$location"
cd "$location" || exit
tree
echo "Restoring..."
rsync -rv --progress "$location/" "$HOME/Applications" # Command: rsync to backup files, -n to dry_run
