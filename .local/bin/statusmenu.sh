#!/usr/bin/env bash

case "$(printf "Task Manager\\nCpu Thermals\\nGpu Thermals\\nList Updates" | xmenu)" in
    "Task Manager") st -e htop ;;
    "Cpu Thermals") notify-send "CPU:" "$(sensors | sed -n '21,24p' | awk '{print $1 $2 $3}' | sed 's/+/ /')" ;;
    "Gpu Thermals") notify-send "GPU:" "$(sensors | sed -n '5p;9p' | awk '{print $1 $2}' | sed 's/+/ /')" ;;
    "List Updates") notify-send "Updates:" "$(checkupdates | awk '{print $1}' | head)" ;;
esac
