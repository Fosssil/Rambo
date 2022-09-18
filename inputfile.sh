#!/usr/bin/env bash
# Add targated locations to take backup for following files
# and then parse it into automatic backup script .i.e. auto_bck.sh
echo -e "\e[33m 
/home/$USER/.bash_history 
/home/$USER/.bashrc 
/home/$USER/.zshrc 
/home/$USER/.zsh_history 
/home/$USER/.byobu
/etc/gimp/
/etc/pacman.d/
\e[0m"