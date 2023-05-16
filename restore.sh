#!/usr/bin/env bash
source color.sh

read -r -p "Enter Location: " location < <(find / -type d -name "BACKUP*" 2>/dev/null | fzf)
echo "$location"
echo "Restoring..."
