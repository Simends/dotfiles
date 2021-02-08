#!/usr/bin/env bash

case "$(printf "List Updates\\nCpu Thermals\\nGpu Thermals\\nStop Redshift" | xmenu)" in
    "Cpu Thermals") notify-send "CPU:" "$(sensors | sed -n '21,24p' | awk '{print $1 $2 $3}' | sed 's/+/ /')" ;;
    "Gpu Thermals") notify-send "GPU:" "$(sensors | sed -n '5p;9p' | awk '{print $1 $2}' | sed 's/+/ /')" ;;
    "List Updates") notify-send "Updates:" "$(checkupdates | awk '{print $1}' | head)" ;;
    "Stop Redshift") killall redshift ;;
esac
