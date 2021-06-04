#!/bin/sh

rclick() {
    case "$(printf "Do not disturb\\nRandom Wallpaper\\nSet Wallpaper\\nStop Redshift\\nStop Picom" | xmenu)" in
        "Do not disturb") dunstctl close-all && dunstctl set-paused toggle && notify-send "Do not disturb" "Do not disturb is now off" ;;
        "Random Wallpaper") exec alacritty -e setwp -R ;;
        "Set Wallpaper") exec alacritty -e setwp -M ;;
        "Stop Redshift") killall redshift ;;
        "Stop Picom") killall picom ;;
    esac
}

case $1 in
    1) exec alacritty -e calcurse ;;
    3) rclick ;;
esac

