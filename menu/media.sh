#!/bin/sh

MenuOpts="$1"
MenuProg="bemenu $MenuOpts"
Terminal="$2"
Browser="$3"

MediaOpts="Play/Pause\nNext\nPrevious"
MediaMenu=$(echo -e "$MediaOpts" | $MenuProg)
case "$MediaMenu" in
    "Play/Pause")
        playerctl play-pause
        ;;
    "Next")
        playerctl next
        ;;
    "Previous")
        playerctl previous
        ;;
esac
