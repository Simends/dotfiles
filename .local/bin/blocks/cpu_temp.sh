#!/bin/sh

ICONn=" " # icon for normal temperatures
ICONc=" " # icon for critical temperatures

crit=70 # critical temperature

read -r temp </sys/class/thermal/thermal_zone2/temp
temp=${temp%???}

if [ "$temp" -lt "$crit" ] ; then
    printf "\x0e$ICONn$temp°C\x0b"
else
    printf "\x0c$ICONc$temp°C\x0b"
fi
