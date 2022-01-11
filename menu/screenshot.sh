#!/bin/sh

MenuOpts="$1"
MenuProg="bemenu $MenuOpts"
Terminal="$2"
Browser="$3"

ScrFilename="$(xdg-user-dir PICTURES)/$(date +'screenshot_%H:%M:%S_%d%m%Y.png')"
ScrOpts="All Monitors\nMain Monitor\nSelected Region"
ScrMenu=$(echo -e "$ScrOpts" | $MenuProg)
case "$ScrMenu" in
    "All Monitors")
        grim "$ScrFilename"
        ;;
    "Main Monitor")
        grim -o DP-1 "$ScrFilename"
        ;;
    "Selected Region")
        grim -g "$(slurp)" "$ScrFilename"
        ;;
esac
