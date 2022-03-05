#!/bin/sh

MenuOpts="$1"
MenuProg="dmenu $MenuOpts"
Terminal="$2"
Browser="$3"

ScrFilename="$(xdg-user-dir PICTURES)/$(date +'screenshot_%H:%M:%S_%d%m%Y.png')"
ScrOpts="Focused Window\nAll Monitors\nSelected Region"
ScrMenu=$(echo -e "$ScrOpts" | $MenuProg)
case "$ScrMenu" in
    "Focused Window")
        scrot -u "$ScrFilename"
        ;;
    "All Monitors")
        scrot -m "$ScrFilename"
        ;;
    "Selected Region")
        scrot -s "$ScrFilename"
        ;;
esac
