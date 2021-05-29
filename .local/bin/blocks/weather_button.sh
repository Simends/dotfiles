#!/bin/sh

case $1 in
    1) exec alacritty --hold -e curl "wttr.in/?pAF" ;;
    3) exec alacritty --hold -e curl "wttr.in/moon?pAF" ;;
esac

