#! /bin/bash
# A script to make a list of all explicitly installed packages to be used with cron

rm -f ~/.local/share/package-list

# Arch:
pacman -Qet | awk '{print $1}' >> ~/.local/share/package-list
