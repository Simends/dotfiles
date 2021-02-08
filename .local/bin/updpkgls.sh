#! /bin/bash
# A script to make a list of all explicitly installed packages to be used with cron

# Path to the package list
PKGLSPATH=~/.local/share/package-list

rm -f $PKGLSPATH

# Arch:
pacman -Qet | awk '{print $1}' >> $PKGLSPATH
