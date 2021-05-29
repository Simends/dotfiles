#!/bin/sh

case $1 in
    1) exec alacritty --hold -e checkupdates ;;
    3) exec alacritty -e sudo pacman -Syu ;;
esac
