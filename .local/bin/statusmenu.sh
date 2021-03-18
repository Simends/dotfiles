#!/usr/bin/env bash

case "$(printf "Do not disturb\\nList Updates\\nCpu Thermals\\nGpu Thermals\\nStop Redshift" | xmenu)" in
    "Do not disturb") dunstctl close-all && dunstctl set-paused toggle && notify-send "Do not disturb" "Do not disturb is now off" ;;
    "Cpu Thermals") notify-send "CPU:" "$(sensors | sed -n '21,24p' | awk '{print $1 $2 $3}' | sed 's/+/ /')" ;;
    "Gpu Thermals") notify-send "GPU:" "$(sensors | sed -n '5p;9p' | awk '{print $1 $2}' | sed 's/+/ /')" ;;
    "List Updates") notify-send "Updates:" "$(checkupdates | awk '{print $1}' | head)" ;;
    "Stop Redshift") killall redshift ;;
esac
